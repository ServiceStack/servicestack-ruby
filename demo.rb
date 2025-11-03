#!/usr/bin/env ruby
# Demo script showing ServiceStack Ruby Client capabilities

require_relative 'lib/servicestack'

def print_header(title)
  puts "\n" + "=" * 60
  puts title.center(60)
  puts "=" * 60
end

def print_section(title)
  puts "\n#{title}"
  puts "-" * 60
end

print_header("ServiceStack Ruby Client Demo")

# 1. Library Information
print_section("1. Library Information")
puts "Version: #{ServiceStack::VERSION}"
puts "Available Classes:"
puts "  - ServiceStack::JsonServiceClient"
puts "  - ServiceStack::ServiceClientBase"
puts "  - ServiceStack::ResponseStatus"
puts "  - ServiceStack::WebServiceException"

# 2. Client Creation
print_section("2. Creating a Client")
client = ServiceStack::JsonServiceClient.new('https://api.example.org')
puts "✓ Client created"
puts "  Base URL: #{client.base_url}"
puts "  Timeout: #{client.timeout}s"

# 3. Configuration
print_section("3. Configuring the Client")
client.timeout = 30
puts "✓ Timeout set to #{client.timeout}s"

client.headers['X-API-Key'] = 'demo-key'
client.headers['X-Client'] = 'Ruby/1.0'
puts "✓ Custom headers added: #{client.headers.keys.join(', ')}"

client.set_bearer_token('demo-token-12345')
puts "✓ Bearer token authentication configured"

# 4. DTO Definition
print_section("4. Defining DTOs")

class User
  attr_accessor :id, :name, :email
  
  def initialize(hash = {})
    @id = hash['id'] || hash[:id]
    @name = hash['name'] || hash[:name]
    @email = hash['email'] || hash[:email]
  end
  
  def to_hash
    { 'id' => @id, 'name' => @name, 'email' => @email }
  end
  
  def to_s
    "##{@id}: #{@name} <#{@email}>"
  end
end

user = User.new(id: 1, name: 'John Doe', email: 'john@example.com')
puts "✓ User DTO created: #{user}"
puts "  Serialized: #{user.to_hash}"

# 5. Request Examples
print_section("5. Request Methods Available")
puts "✓ GET    - client.get(request, ResponseType, path: '/resource')"
puts "✓ POST   - client.post(request, ResponseType, path: '/resource')"
puts "✓ PUT    - client.put(request, ResponseType, path: '/resource')"
puts "✓ DELETE - client.delete(request, ResponseType, path: '/resource')"
puts "✓ PATCH  - client.patch(request, ResponseType, path: '/resource')"

# 6. Error Handling
print_section("6. Error Handling")
puts "ServiceStack errors are raised as WebServiceException:"
puts ""
puts "  begin"
puts "    response = client.post(request)"
puts "  rescue ServiceStack::WebServiceException => e"
puts "    puts \"Error: \#{e.error_message}\""
puts "    puts \"Code: \#{e.error_code}\""
puts "    puts \"Status: \#{e.status_code}\""
puts "  end"

# 7. Features Summary
print_section("7. Features Summary")
features = [
  "✓ Typed Request/Response DTOs",
  "✓ All HTTP verbs (GET, POST, PUT, DELETE, PATCH)",
  "✓ Basic Authentication",
  "✓ Bearer Token Authentication",
  "✓ Custom Headers",
  "✓ ServiceStack error response handling",
  "✓ Timeout configuration",
  "✓ Query string parameters for GET requests",
  "✓ JSON request/response serialization",
  "✓ Automatic route resolution"
]

features.each { |f| puts "  #{f}" }

# 8. Example Use Cases
print_section("8. Example Use Cases")
puts "• REST API integration"
puts "• Microservices communication"
puts "• Backend-as-a-Service (BaaS) clients"
puts "• Mobile app backends"
puts "• Web application APIs"
puts "• Serverless function APIs"

print_header("Demo Complete!")
puts "\nFor more examples, check the 'examples/' directory:"
puts "  - basic_usage.rb"
puts "  - hello_world.rb"
puts "  - authentication.rb"
puts "  - typed_dtos.rb"
puts "  - error_handling.rb"
puts "\nFor documentation, see README.md"
puts ""
