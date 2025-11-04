module ServiceStack
  # Base class for ServiceStack service clients
  class ServiceClientBase
    attr_accessor :base_url, :username, :password, :bearer_token, :timeout, :headers

    def initialize(base_url)
      @base_url = base_url.chomp('/')
      @username = nil
      @password = nil
      @bearer_token = nil
      @timeout = 60
      @headers = {}
    end

    # Set basic authentication credentials
    def set_credentials(username, password)
      @username = username
      @password = password
      self
    end

    # Set bearer token authentication
    def set_bearer_token(token)
      @bearer_token = token
      self
    end

    protected

    def create_request(uri, method)
      request = case method.upcase
                when 'GET'
                  Net::HTTP::Get.new(uri)
                when 'POST'
                  Net::HTTP::Post.new(uri)
                when 'PUT'
                  Net::HTTP::Put.new(uri)
                when 'DELETE'
                  Net::HTTP::Delete.new(uri)
                when 'PATCH'
                  Net::HTTP::Patch.new(uri)
                else
                  raise ArgumentError, "Unsupported HTTP method: #{method}"
                end

      # Add custom headers
      @headers.each do |key, value|
        request[key] = value
      end

      # Add authentication
      if @bearer_token
        request['Authorization'] = "Bearer #{@bearer_token}"
      elsif @username && @password
        request.basic_auth(@username, @password)
      end

      request
    end

    def send_request(uri, http, request)
      response = http.request(request)
      handle_response(response)
    end

    def handle_response(response)
      case response.code.to_i
      when 200..299
        # Success
        if response.body && !response.body.empty?
          JSON.parse(response.body)
        else
          {}
        end
      else
        # Error response
        handle_error_response(response)
      end
    end

    def handle_error_response(response)
      status_code = response.code.to_i
      status_description = response.message

      response_dto = nil
      response_status = nil

      if response.body && !response.body.empty?
        begin
          response_dto = JSON.parse(response.body)
          if response_dto.is_a?(Hash) && response_dto['responseStatus']
            response_status = ResponseStatus.new(response_dto['responseStatus'])
          end
        rescue JSON::ParserError
          # Body is not JSON
        end
      end

      message = if response_status
                  response_status.message || status_description
                else
                  status_description
                end

      raise WebServiceException.new(
        message,
        status_code: status_code,
        status_description: status_description,
        response_status: response_status,
        response_body: response.body
      )
    end
  end
end
