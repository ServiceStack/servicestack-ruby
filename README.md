# ServiceStack Ruby Client

Ruby client library for [ServiceStack](https://servicestack.net/) - a simple, fast, versatile and highly productive full-featured Web and Web Services Framework.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'servicestack-client'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install servicestack-client
```

## Usage

### Creating a Service Client

```ruby
require 'servicestack'

# Create a client with your ServiceStack API base URL
client = ServiceStack::JsonServiceClient.new('https://example.org')
```

### Making Requests

#### Define your DTOs (Data Transfer Objects)

ServiceStack uses typed DTOs for requests and responses. Define them as Ruby classes:

```ruby
class Hello
  attr_accessor :name

  def initialize(hash = {})
    @name = hash['name'] || hash[:name]
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
```

#### Send a GET request

```ruby
request = Hello.new(name: 'World')
response = client.get(request, HelloResponse)
puts response.result  # "Hello, World!"
```

#### Send a POST request

```ruby
request = Hello.new(name: 'World')
response = client.post(request, HelloResponse)
puts response.result
```

#### Using Hash-based requests

You can also use plain hashes if you don't want to define DTO classes:

```ruby
response = client.post({ name: 'World' })
puts response['result']
```

### Authentication

#### Basic Authentication

```ruby
client.set_credentials('username', 'password')
response = client.post(request)
```

#### Bearer Token Authentication

```ruby
client.set_bearer_token('your-token-here')
response = client.post(request)
```

### Custom Headers

```ruby
client.headers['X-Custom-Header'] = 'value'
response = client.post(request)
```

### Timeout Configuration

```ruby
client.timeout = 30  # seconds
```

### Error Handling

ServiceStack errors are raised as `WebServiceException`:

```ruby
begin
  response = client.post(request)
rescue ServiceStack::WebServiceException => e
  puts "Error: #{e.error_message}"
  puts "Status Code: #{e.status_code}"
  puts "Error Code: #{e.error_code}"
end
```

### HTTP Methods

The client supports all standard HTTP methods:

```ruby
client.get(request, ResponseType)     # GET request
client.post(request, ResponseType)    # POST request
client.put(request, ResponseType)     # PUT request
client.delete(request, ResponseType)  # DELETE request
client.patch(request, ResponseType)   # PATCH request
```

Or use the generic `send` method:

```ruby
client.send(request, method: 'POST', response_type: ResponseType)
```

## Example: Complete Integration

```ruby
require 'servicestack'

# Define DTOs
class CreateUser
  attr_accessor :name, :email

  def initialize(hash = {})
    @name = hash['name'] || hash[:name]
    @email = hash['email'] || hash[:email]
  end

  def to_hash
    { 'name' => @name, 'email' => @email }
  end
end

class CreateUserResponse
  attr_accessor :id, :name, :email

  def initialize(hash = {})
    @id = hash['id'] || hash[:id]
    @name = hash['name'] || hash[:name]
    @email = hash['email'] || hash[:email]
  end
end

# Create client
client = ServiceStack::JsonServiceClient.new('https://api.example.org')
client.set_bearer_token('your-api-token')

# Make request
begin
  request = CreateUser.new(name: 'John Doe', email: 'john@example.com')
  response = client.post(request, CreateUserResponse)
  puts "User created with ID: #{response.id}"
rescue ServiceStack::WebServiceException => e
  puts "Error creating user: #{e.error_message}"
end
```

## Features

- ✅ Typed Request/Response DTOs
- ✅ All HTTP verbs (GET, POST, PUT, DELETE, PATCH)
- ✅ Basic Authentication
- ✅ Bearer Token Authentication
- ✅ Custom Headers
- ✅ ServiceStack error response handling
- ✅ Timeout configuration
- ✅ Query string parameters for GET requests
- ✅ JSON request/response serialization

## ServiceStack Resources

- [ServiceStack Home](https://servicestack.net/)
- [ServiceStack Docs](https://docs.servicestack.net/)
- [Add ServiceStack Reference](https://docs.servicestack.net/add-servicestack-reference)

## License

BSD-3-Clause
