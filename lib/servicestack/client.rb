# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

module ServiceStack
  # ServiceStack HTTP Client for making requests to ServiceStack services
  class Client
    attr_reader :base_url
    attr_accessor :timeout, :open_timeout

    # Initialize a new ServiceStack client
    #
    # @param base_url [String] The base URL of the ServiceStack service
    # @param options [Hash] Additional options
    # @option options [Integer] :timeout Request timeout in seconds (default: 60)
    # @option options [Integer] :open_timeout Connection timeout in seconds (default: 60)
    def initialize(base_url, options = {})
      @base_url = base_url.chomp("/")
      @timeout = options[:timeout] || 60
      @open_timeout = options[:open_timeout] || 60
    end

    # Make a GET request
    #
    # @param path [String] The request path
    # @param params [Hash] Query parameters
    # @return [Hash] The parsed JSON response
    def get(path, params = {})
      request(:get, path, params: params)
    end

    # Make a POST request
    #
    # @param path [String] The request path
    # @param body [Hash] The request body
    # @return [Hash] The parsed JSON response
    def post(path, body = {})
      request(:post, path, body: body)
    end

    # Make a PUT request
    #
    # @param path [String] The request path
    # @param body [Hash] The request body
    # @return [Hash] The parsed JSON response
    def put(path, body = {})
      request(:put, path, body: body)
    end

    # Make a PATCH request
    #
    # @param path [String] The request path
    # @param body [Hash] The request body
    # @return [Hash] The parsed JSON response
    def patch(path, body = {})
      request(:patch, path, body: body)
    end

    # Make a DELETE request
    #
    # @param path [String] The request path
    # @param params [Hash] Query parameters
    # @return [Hash] The parsed JSON response
    def delete(path, params = {})
      request(:delete, path, params: params)
    end

    private

    # Make an HTTP request
    #
    # @param method [Symbol] The HTTP method
    # @param path [String] The request path
    # @param params [Hash] Query parameters
    # @param body [Hash] Request body
    # @return [Hash] The parsed JSON response
    def request(method, path, params: {}, body: nil)
      uri = build_uri(path, params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.read_timeout = @timeout
      http.open_timeout = @open_timeout

      request = build_request(method, uri, body)
      response = http.request(request)

      handle_response(response)
    end

    # Build URI with query parameters
    #
    # @param path [String] The request path
    # @param params [Hash] Query parameters
    # @return [URI] The constructed URI
    def build_uri(path, params)
      url = "#{@base_url}/#{path.sub(%r{^/}, '')}"
      uri = URI(url)
      
      unless params.empty?
        uri.query = URI.encode_www_form(params)
      end
      
      uri
    end

    # Build HTTP request object
    #
    # @param method [Symbol] The HTTP method
    # @param uri [URI] The request URI
    # @param body [Hash] Request body
    # @return [Net::HTTPRequest] The HTTP request object
    def build_request(method, uri, body)
      request_class = case method
                      when :get then Net::HTTP::Get
                      when :post then Net::HTTP::Post
                      when :put then Net::HTTP::Put
                      when :patch then Net::HTTP::Patch
                      when :delete then Net::HTTP::Delete
                      else
                        raise ArgumentError, "Unsupported HTTP method: #{method}"
                      end

      request = request_class.new(uri)
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      
      if body && !body.empty?
        request.body = body.to_json
      end

      request
    end

    # Handle HTTP response
    #
    # @param response [Net::HTTPResponse] The HTTP response
    # @return [Hash] The parsed JSON response
    # @raise [ServiceStack::Error] If the response indicates an error
    def handle_response(response)
      case response
      when Net::HTTPSuccess
        parse_json_response(response.body)
      when Net::HTTPClientError, Net::HTTPServerError
        error_message = "HTTP #{response.code}: #{response.message}"
        begin
          error_data = parse_json_response(response.body)
          error_message += " - #{error_data}" if error_data
        rescue JSON::ParserError
          error_message += " - #{response.body}" unless response.body.empty?
        end
        raise ServiceStack::Error, error_message
      else
        raise ServiceStack::Error, "Unexpected response: #{response.code} #{response.message}"
      end
    end

    # Parse JSON response
    #
    # @param body [String] The response body
    # @return [Hash, Array, nil] The parsed JSON
    def parse_json_response(body)
      return nil if body.nil? || body.empty?
      JSON.parse(body)
    rescue JSON::ParserError => e
      raise ServiceStack::Error, "Invalid JSON response: #{e.message}"
    end
  end
end
