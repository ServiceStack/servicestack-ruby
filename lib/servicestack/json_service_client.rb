# frozen_string_literal: true

require 'json'
require 'net/http'
require 'securerandom'
require 'uri'
require_relative 'dto'
require_relative 'types'
require_relative 'web_service_exception'

module ServiceStack
  # HTTP Methods used by ServiceStack APIs.
  module HttpMethods
    GET = 'GET'
    POST = 'POST'
    PUT = 'PUT'
    PATCH = 'PATCH'
    DELETE = 'DELETE'
    OPTIONS = 'OPTIONS'
    HEAD = 'HEAD'
  end

  # A file uploaded in a multipart/form-data Request.
  #
  # Its contents can be supplied as a String or any IO that responds to `read`,
  # e.g. a File or StringIO.
  class UploadFile
    attr_accessor :field_name, :file_name, :content_type, :stream

    def initialize(field_name: 'file', file_name: nil, content_type: nil, stream: nil)
      @field_name = field_name
      @file_name = file_name
      @content_type = content_type
      @stream = stream
    end

    # The file contents to upload.
    def contents
      return @stream unless @stream.respond_to?(:read)

      @stream.binmode if @stream.respond_to?(:binmode)
      @stream.read
    end
  end

  # Either the typed Response of a successful API Request or the structured
  # ResponseStatus error of a failed one, returned by `api`.
  class ApiResult
    attr_reader :response, :error

    def initialize(response: nil, error: nil)
      @response = response
      @error = error
    end

    def succeeded? = @error.nil?
    def failed? = !@error.nil?
    def error_code = @error&.error_code
    def error_message = @error&.message
    def field_error(field_name) = @error&.field_error(field_name)
  end

  # Client for consuming ServiceStack APIs with generated typed DTOs.
  #
  #   client = ServiceStack::JsonServiceClient.new('https://example.org')
  #   res = client.send(Hello.new(name: 'World'))
  #   puts res.result
  class JsonServiceClient
    MIME_TYPE_JSON = 'application/json'

    attr_accessor :base_url, :reply_base_url, :oneway_base_url, :headers,
                  :bearer_token, :refresh_token, :refresh_token_uri,
                  :user_name, :password, :request_filter, :response_filter,
                  :timeout, :cookies, :on_authentication_required

    class << self
      # Filters applied to every Request and Response of all clients.
      attr_accessor :global_request_filter, :global_response_filter
    end

    def initialize(base_url)
      raise ArgumentError, 'base_url is required' if base_url.nil? || base_url.to_s.empty?

      @base_url = base_url.to_s.sub(%r{/+$}, '')
      @headers = { 'Accept' => MIME_TYPE_JSON }
      @cookies = {}
      @timeout = 60
      set_base_path('api')
    end

    # Changes the base path Request DTOs are sent to, e.g. 'api'.
    # Use an empty base_path for the /json/reply pre-defined routes.
    def set_base_path(base_path = '')
      if base_path.nil? || base_path.to_s.empty?
        @reply_base_url = combine_with(@base_url, 'json/reply')
        @oneway_base_url = combine_with(@base_url, 'json/oneway')
      else
        @reply_base_url = combine_with(@base_url, base_path)
        @oneway_base_url = combine_with(@base_url, base_path)
      end
      self
    end

    # Sets the JWT or API Key sent in the Bearer Authorization header.
    def set_bearer_token(token)
      @bearer_token = token
      self
    end

    # Sets the Refresh Token used to fetch a new Bearer Token when a Request
    # returns 401 Unauthorized.
    def set_refresh_token(token)
      @refresh_token = token
      self
    end

    # Sets the UserName and Password sent in the HTTP Basic Auth header.
    def set_credentials(user_name, password)
      @user_name = user_name
      @password = password
      self
    end

    # Sets a HTTP Header sent with each Request.
    def set_header(name, value)
      @headers[name] = value
      self
    end

    # ── Typed API ──

    # Sends a Request DTO with the HTTP Method it's annotated with, returning
    # its typed Response.
    #
    # Note this overrides Object#send, use __send__ or send_dto for Ruby's
    # dynamic dispatch.
    def send(request, method: nil, body: nil, args: nil)
      method ||= resolve_http_method(request)
      execute_typed(method, create_url_from_dto(method, request), body || request,
                    resolve_response_type(request), args: args)
    end
    alias send_dto send

    def get(request, args: nil) = send(request, method: HttpMethods::GET, args: args)
    def post(request, body: nil, args: nil) = send(request, method: HttpMethods::POST, body: body, args: args)
    def put(request, body: nil, args: nil) = send(request, method: HttpMethods::PUT, body: body, args: args)
    def patch(request, body: nil, args: nil) = send(request, method: HttpMethods::PATCH, body: body, args: args)
    def delete(request, args: nil) = send(request, method: HttpMethods::DELETE, args: args)

    # Sends a Request DTO that doesn't return a Response Body.
    def send_void(request, args: nil)
      method = resolve_http_method(request)
      execute(method, create_url_from_dto(method, request), request, args: args)
      nil
    end

    # Sends a Request DTO, returning an ApiResult containing either its typed
    # Response or the structured ResponseStatus error.
    def api(request, method: nil, args: nil)
      ApiResult.new(response: send(request, method: method, args: args))
    rescue WebServiceException => e
      ApiResult.new(error: e.response_status || ResponseStatus.new(
        error_code: e.status_description, message: e.message
      ))
    end

    # Sends multiple Request DTOs of the same Type in a single Request.
    def send_all(requests)
      return [] if requests.nil? || requests.empty?

      # Brackets are encoded so the batch URL is a valid URI
      url = combine_with(@reply_base_url, "#{type_name_of(requests.first)}%5B%5D")
      response_type = resolve_response_type(requests.first)
      json = execute(HttpMethods::POST, url, requests)
      parsed = json.to_s.empty? ? [] : JSON.parse(json)
      return parsed unless response_type

      parsed.map { |x| response_type.from_hash(x) }
    end

    # Sends a Request DTO to a one-way endpoint, ignoring any Response.
    def publish(request)
      url = combine_with(@oneway_base_url, type_name_of(request))
      execute(HttpMethods::POST, url, request)
      nil
    end

    # Signs in with UserName and Password credentials, using the Bearer Token
    # and Session Cookies the Server returns for subsequent Requests.
    def authenticate(user_name, password)
      res = send(Authenticate.new(provider: 'credentials', user_name: user_name, password: password))
      @bearer_token = res.bearer_token unless res.bearer_token.to_s.empty?
      @refresh_token = res.refresh_token unless res.refresh_token.to_s.empty?
      res
    end

    # ── URL API ──

    # Sends a GET Request to a custom relative path or absolute URL.
    def get_url(path, response_as: nil, args: nil)
      send_url(path, method: HttpMethods::GET, response_as: response_as, args: args)
    end

    def post_url(path, body: nil, response_as: nil, args: nil)
      send_url(path, method: HttpMethods::POST, body: body, response_as: response_as, args: args)
    end

    def put_url(path, body: nil, response_as: nil, args: nil)
      send_url(path, method: HttpMethods::PUT, body: body, response_as: response_as, args: args)
    end

    def patch_url(path, body: nil, response_as: nil, args: nil)
      send_url(path, method: HttpMethods::PATCH, body: body, response_as: response_as, args: args)
    end

    def delete_url(path, response_as: nil, args: nil)
      send_url(path, method: HttpMethods::DELETE, response_as: response_as, args: args)
    end

    # Sends a Request to a custom relative path or absolute URL.
    def send_url(path, method: HttpMethods::GET, body: nil, response_as: nil, args: nil)
      execute_typed(method, to_absolute_url(path), body, response_as, args: args)
    end

    # Sends a Request to a custom URL, returning its raw Response Body.
    def send_url_string(path, method: HttpMethods::GET, body: nil, args: nil)
      execute(method, to_absolute_url(path), body, args: args)
    end

    # ── File Uploads ──

    # Uploads a file with a Request DTO as a multipart/form-data Request,
    # returning its typed Response, e.g:
    #
    #   File.open('photo.png', 'rb') do |file|
    #     client.post_file_with_request(UploadPhoto.new(album: 'Holiday'),
    #       ServiceStack::UploadFile.new(field_name: 'file', file_name: 'photo.png',
    #                                    content_type: 'image/png', stream: file))
    #   end
    def post_file_with_request(request, file, args: nil)
      post_files_with_request(request, [file], args: args)
    end

    # Uploads multiple files with a Request DTO as a multipart/form-data Request.
    def post_files_with_request(request, files, args: nil)
      url = create_url_from_dto(HttpMethods::POST, request)
      post_files_with_request_url(url, request, files, response_as: resolve_response_type(request), args: args)
    end

    # Uploads files with a Request DTO to a custom relative path or absolute URL.
    def post_files_with_request_url(path, request, files, response_as: nil, args: nil)
      boundary = "----ServiceStackFormBoundary#{SecureRandom.hex(12)}"
      body = multipart_body(boundary, request, files)

      json = execute(HttpMethods::POST, to_absolute_url(path), body, args: args,
                                                                    content_type: "multipart/form-data; boundary=#{boundary}")
      return nil if response_as.nil?
      return json if response_as == String

      parsed = json.to_s.strip.empty? ? {} : JSON.parse(json)
      return parsed unless response_as.respond_to?(:from_hash)

      response_as.from_hash(parsed)
    end

    # Converts a relative path into an absolute URL of this client.
    def to_absolute_url(path_or_url)
      return path_or_url if path_or_url.to_s.start_with?('http://', 'https://')

      combine_with(@base_url, path_or_url)
    end

    # The URL a Request DTO is sent to, appending the populated DTO properties
    # to the QueryString for Requests without a Body.
    def create_url_from_dto(method, request)
      url = combine_with(@reply_base_url, type_name_of(request))
      return url if has_request_body?(method)

      append_query_string(url, to_hash(request))
    end

    private

    def execute_typed(method, url, body, response_type, args: nil)
      json = execute(method, url, body, args: args)
      return nil if response_type.nil?
      return json if response_type == String

      parsed = json.to_s.strip.empty? ? {} : JSON.parse(json)
      return parsed unless response_type.respond_to?(:from_hash)

      response_type.from_hash(parsed)
    end

    def execute(method, url, body, args: nil, retry_on_auth_failure: true, content_type: nil)
      url = append_query_string(url, args) if args && !args.empty?

      uri = URI.parse(url)
      request = new_http_request(method, uri, body, content_type: content_type)

      @request_filter&.call(request)
      self.class.global_request_filter&.call(request)

      response = http_client(uri).request(request)

      @response_filter&.call(response)
      self.class.global_response_filter&.call(response)

      capture_cookies(response)

      status_code = response.code.to_i
      if status_code == 401 && retry_on_auth_failure && handle_authentication_required
        return execute(method, url, body, retry_on_auth_failure: false, content_type: content_type)
      end

      # Redirects aren't followed, e.g. Services that redirect to a HTML sign in
      # page would otherwise return an empty Response
      raise to_web_service_exception(response) if status_code >= 300

      response.body
    rescue WebServiceException
      raise
    rescue StandardError => e
      raise WebServiceException.new(e.message, inner_exception: e)
    end

    def new_http_request(method, uri, body, content_type: nil)
      request_class = case method.to_s.upcase
                      when HttpMethods::GET then Net::HTTP::Get
                      when HttpMethods::POST then Net::HTTP::Post
                      when HttpMethods::PUT then Net::HTTP::Put
                      when HttpMethods::PATCH then Net::HTTP::Patch
                      when HttpMethods::DELETE then Net::HTTP::Delete
                      when HttpMethods::OPTIONS then Net::HTTP::Options
                      when HttpMethods::HEAD then Net::HTTP::Head
                      else Net::HTTP::Post
                      end

      request = request_class.new(uri.request_uri)
      @headers.each { |name, value| request[name] = value }

      if @bearer_token
        request['Authorization'] = "Bearer #{@bearer_token}"
      elsif @user_name || @password
        request.basic_auth(@user_name.to_s, @password.to_s)
      end

      request['Cookie'] = @cookies.map { |k, v| "#{k}=#{v}" }.join('; ') unless @cookies.empty?

      if body && has_request_body?(method)
        request['Content-Type'] = content_type || request['Content-Type'] || MIME_TYPE_JSON
        request.body = body.is_a?(String) ? body : JSON.generate(to_hash(body))
      end

      request
    end

    def http_client(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.read_timeout = @timeout if @timeout
      http.open_timeout = @timeout if @timeout
      http
    end

    # Retains the Session Cookies returned by the Server, e.g. ss-id/ss-pid
    def capture_cookies(response)
      cookies = response.get_fields('set-cookie')
      return if cookies.nil?

      cookies.each do |set_cookie|
        pair = set_cookie.split(';').first.to_s
        name, _, value = pair.partition('=')
        @cookies[name.strip] = value.strip unless name.strip.empty?
      end
    end

    # Re-authenticates the client after a Request returned 401 Unauthorized,
    # returning whether the Request should be retried.
    #
    # Uses the Refresh Token when configured, otherwise the
    # `on_authentication_required` callback.
    def handle_authentication_required
      return true if refresh_access_token
      return false if @on_authentication_required.nil?

      if @on_authentication_required.arity.zero?
        @on_authentication_required.call
      else
        @on_authentication_required.call(self)
      end
      true
    rescue StandardError
      # Re-authenticating failed, return the original 401 Response
      false
    end

    def refresh_access_token
      return false if @refresh_token.to_s.empty?

      url = @refresh_token_uri || combine_with(@reply_base_url, 'GetAccessToken')
      json = execute(HttpMethods::POST, to_absolute_url(url),
                     GetAccessToken.new(refresh_token: @refresh_token),
                     retry_on_auth_failure: false)
      res = GetAccessTokenResponse.from_hash(JSON.parse(json.to_s.empty? ? '{}' : json))
      return false if res.access_token.to_s.empty?

      @bearer_token = res.access_token
      true
    rescue StandardError
      false
    end

    def to_web_service_exception(response)
      status_code = response.code.to_i
      response_status = nil

      body = response.body.to_s
      unless body.empty?
        begin
          hash = JSON.parse(body)
          if hash.is_a?(Hash)
            status_hash = hash['responseStatus'] || hash['ResponseStatus']
            status_hash = hash if status_hash.nil? && (hash['errorCode'] || hash['message'])
            response_status = ResponseStatus.from_hash(status_hash) if status_hash
          end
        rescue JSON::ParserError
          # Services can return non JSON errors, e.g. a HTML error page
        end
      end

      if response_status.nil? && status_code >= 300 && status_code < 400
        location = response['location']
        response_status = ResponseStatus.new(
          error_code: 'Redirect',
          message: "Request was redirected#{location ? " to #{location}" : ''}"
        )
      end

      response_status ||= ResponseStatus.new(error_code: response.message, message: response.message)

      WebServiceException.new(
        response_status.message || response.message,
        status_code: status_code,
        status_description: response.message,
        response_status: response_status,
        response_body: body
      )
    end

    def resolve_response_type(request)
      return nil unless request.respond_to?(:response_type)

      request.response_type
    end

    def resolve_http_method(request)
      return request.get_method if request.respond_to?(:get_method) && !request.get_method.to_s.empty?

      name = type_name_of(request)
      case name
      when /\A(Get|Query|Find|Search)/ then HttpMethods::GET
      when /\A(Create)/ then HttpMethods::POST
      when /\A(Update|Replace)/ then HttpMethods::PUT
      when /\A(Patch)/ then HttpMethods::PATCH
      when /\A(Delete|Remove)/ then HttpMethods::DELETE
      else HttpMethods::POST
      end
    end

    def type_name_of(request)
      return request.get_type_name if request.respond_to?(:get_type_name)

      request.class.name.to_s.split('::').last
    end

    def to_hash(dto)
      return dto if dto.is_a?(String)
      return dto.map { |x| to_hash(x) } if dto.is_a?(Array)
      return dto.to_hash if dto.respond_to?(:to_hash)

      dto
    end

    # Builds the multipart/form-data body of a file upload Request, sending the
    # populated Request DTO properties as form fields
    def multipart_body(boundary, request, files)
      body = +''

      to_hash(request).each do |name, value|
        next if value.nil?

        body << "--#{boundary}\r\n"
        body << "Content-Disposition: form-data; name=\"#{name}\"\r\n\r\n"
        body << "#{qs_value(value)}\r\n"
      end

      files.each do |file|
        field_name = file.field_name.to_s.empty? ? 'file' : file.field_name
        file_name = file.file_name.to_s.empty? ? 'file' : file.file_name

        body << "--#{boundary}\r\n"
        body << "Content-Disposition: form-data; name=\"#{field_name}\"; filename=\"#{file_name}\"\r\n"
        body << "Content-Type: #{file.content_type || 'application/octet-stream'}\r\n\r\n"
        body << file.contents.to_s.dup.force_encoding(Encoding::BINARY)
        body << "\r\n"
      end

      body << "--#{boundary}--\r\n"
      body.force_encoding(Encoding::BINARY)
    end

    def has_request_body?(method)
      !%w[GET DELETE HEAD OPTIONS].include?(method.to_s.upcase)
    end

    def combine_with(base_url, path)
      base = base_url.to_s.sub(%r{/+$}, '')
      rel = path.to_s.sub(%r{\A/+}, '').sub(%r{/+$}, '')
      return base if rel.empty?
      return rel if base.empty?

      "#{base}/#{rel}"
    end

    def append_query_string(url, args)
      return url if args.nil? || args.empty?

      params = args.filter_map do |key, value|
        next if value.nil?

        "#{URI.encode_www_form_component(key.to_s)}=#{URI.encode_www_form_component(qs_value(value))}"
      end
      return url if params.empty?

      "#{url}#{url.include?('?') ? '&' : '?'}#{params.join('&')}"
    end

    def qs_value(value)
      case value
      when nil then ''
      when true, false then value.to_s
      when Array then "[#{value.map { |x| qs_value(x) }.join(',')}]"
      when Hash then "{#{value.map { |k, v| "#{k}:#{qs_value(v)}" }.join(',')}}"
      when DateTime, Time, Date then value.iso8601
      else value.to_s
      end
    end
  end
end
