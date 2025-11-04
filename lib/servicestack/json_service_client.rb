require 'net/http'
require 'uri'
require 'json'

module ServiceStack
  # JsonServiceClient for making typed requests to ServiceStack services
  class JsonServiceClient < ServiceClientBase
    
    # Send a GET request
    # @param request [Object] Request DTO with to_hash method or Hash
    # @param response_type [Class] Optional response class to instantiate
    # @param path [String] Optional explicit path to use instead of deriving from request type
    # @return [Object, Hash] Response object or hash
    def get(request, response_type = nil, path: nil)
      send_request_with_method(request, 'GET', response_type, path)
    end

    # Send a POST request
    # @param request [Object] Request DTO with to_hash method or Hash
    # @param response_type [Class] Optional response class to instantiate
    # @param path [String] Optional explicit path to use instead of deriving from request type
    # @return [Object, Hash] Response object or hash
    def post(request, response_type = nil, path: nil)
      send_request_with_method(request, 'POST', response_type, path)
    end

    # Send a PUT request
    # @param request [Object] Request DTO with to_hash method or Hash
    # @param response_type [Class] Optional response class to instantiate
    # @param path [String] Optional explicit path to use instead of deriving from request type
    # @return [Object, Hash] Response object or hash
    def put(request, response_type = nil, path: nil)
      send_request_with_method(request, 'PUT', response_type, path)
    end

    # Send a DELETE request
    # @param request [Object] Request DTO with to_hash method or Hash
    # @param response_type [Class] Optional response class to instantiate
    # @param path [String] Optional explicit path to use instead of deriving from request type
    # @return [Object, Hash] Response object or hash
    def delete(request, response_type = nil, path: nil)
      send_request_with_method(request, 'DELETE', response_type, path)
    end

    # Send a PATCH request
    # @param request [Object] Request DTO with to_hash method or Hash
    # @param response_type [Class] Optional response class to instantiate
    # @param path [String] Optional explicit path to use instead of deriving from request type
    # @return [Object, Hash] Response object or hash
    def patch(request, response_type = nil, path: nil)
      send_request_with_method(request, 'PATCH', response_type, path)
    end

    # Send a request using the specified HTTP method
    # Automatically determines the route from the request class name or explicit path
    def send(request, method: 'POST', response_type: nil, path: nil)
      send_request_with_method(request, method, response_type, path)
    end

    private

    def send_request_with_method(request, method, response_type, explicit_path = nil)
      # Convert request to hash if it's an object with to_hash method
      request_hash = if request.respond_to?(:to_hash)
                       request.to_hash
                     elsif request.is_a?(Hash)
                       request
                     else
                       raise ArgumentError, "Request must be a Hash or respond to :to_hash"
                     end

      # Determine the route from explicit path, request class/method, or use default
      route = if explicit_path
                explicit_path
              elsif request.respond_to?(:class) && request.class.respond_to?(:route)
                request.class.route
              elsif request.respond_to?(:route)
                request.route
              elsif !request.is_a?(Hash) && request.class.name
                # Use class name as route (e.g., HelloRequest -> /hello)
                class_name = request.class.name.split('::').last
                if class_name.end_with?('Request')
                  "/#{to_route_name(class_name.chomp('Request'))}"
                else
                  "/#{to_route_name(class_name)}"
                end
              else
                # Default route for Hash or anonymous classes - use json/reply/<first key>
                "/json/reply/#{request_hash.keys.first || 'request'}"
              end

      # Build the URL
      url = "#{@base_url}#{route}"
      
      # For GET/DELETE requests, add query string parameters
      if ['GET', 'DELETE'].include?(method.upcase)
        query_string = build_query_string(request_hash)
        url += "?#{query_string}" unless query_string.empty?
      end

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      http.read_timeout = @timeout

      request_obj = create_request(uri, method)
      request_obj['Content-Type'] = 'application/json'
      request_obj['Accept'] = 'application/json'

      # For POST/PUT/PATCH requests, send JSON body
      if ['POST', 'PUT', 'PATCH'].include?(method.upcase)
        request_obj.body = JSON.generate(request_hash)
      end

      response = send_request(uri, http, request_obj)

      # Convert response to typed object if response_type is provided
      if response_type && response.is_a?(Hash)
        if response_type.respond_to?(:new)
          response_type.new(response)
        else
          response
        end
      else
        response
      end
    end

    def to_route_name(name)
      # Convert PascalCase to lowercase with hyphens or keep as-is
      # ServiceStack typically uses the class name as-is
      name.gsub(/([A-Z]+)([A-Z][a-z])/, '\1-\2')
          .gsub(/([a-z\d])([A-Z])/, '\1-\2')
          .downcase
    end

    def build_query_string(hash)
      hash.map do |key, value|
        next if value.nil?
        
        # Convert key to camelCase if needed (ServiceStack convention)
        key_str = key.to_s
        encoded_key = URI.encode_www_form_component(key_str)
        encoded_value = URI.encode_www_form_component(value.to_s)
        "#{encoded_key}=#{encoded_value}"
      end.compact.join('&')
    end
  end
end
