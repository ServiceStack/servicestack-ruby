#!/usr/bin/env ruby
require_relative '../lib/servicestack'

# Basic usage example of ServiceStack Ruby Client

puts "ServiceStack Ruby Client - Basic Usage"
puts "=" * 50

# 1. Create a client
puts "\n1. Creating client..."
client = ServiceStack::JsonServiceClient.new('https://api.example.org')
puts "   Client created with base URL: #{client.base_url}"

# 2. Configure timeout
puts "\n2. Configuring timeout..."
client.timeout = 30
puts "   Timeout set to #{client.timeout} seconds"

# 3. Add authentication
puts "\n3. Adding authentication..."
client.set_bearer_token('your-token-here')
puts "   Bearer token configured"

# Alternative: Basic Auth
# client.set_credentials('username', 'password')

# 4. Add custom headers
puts "\n4. Adding custom headers..."
client.headers['X-API-Version'] = '1.0'
client.headers['X-Client'] = 'Ruby'
puts "   Custom headers added: #{client.headers}"

# 5. Define a simple DTO
puts "\n5. Defining a simple DTO..."

class HelloRequest
  attr_accessor :name

  def initialize(name:)
    @name = name
  end

  def to_hash
    { 'name' => @name }
  end
end

class HelloResponse
  attr_accessor :result

  def initialize(hash = {})
    @result = hash['result'] || hash[:result]
  end
end

puts "   DTOs defined: HelloRequest, HelloResponse"

# 6. Make a request (would work with a real API)
puts "\n6. Making a request..."
puts "   (This would send a POST request to /hello)"

request = HelloRequest.new(name: 'World')
puts "   Request data: #{request.to_hash}"

# With a real ServiceStack API, you would do:
# begin
#   response = client.post(request, HelloResponse, path: '/hello')
#   puts "   Response: #{response.result}"
# rescue ServiceStack::WebServiceException => e
#   puts "   Error: #{e.error_message}"
# end

# 7. Using Hash-based requests
puts "\n7. Using Hash-based requests..."
puts "   You can also use plain hashes:"

hash_request = { name: 'Ruby' }
puts "   Request: #{hash_request}"

# With a real API:
# response = client.post(hash_request, path: '/hello')
# puts "   Response: #{response}"

puts "\n" + "=" * 50
puts "Basic usage example complete!"
puts "\nFor a real-world usage, replace the base URL with your"
puts "ServiceStack API endpoint and uncomment the request code."
