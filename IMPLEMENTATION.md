# ServiceStack Ruby Client Implementation

This document describes the implementation of the ServiceStack JsonServiceClient for Ruby.

## Overview

The ServiceStack Ruby Client is a complete client library for making typed API requests to ServiceStack services. It follows the same patterns and conventions as other ServiceStack client libraries (C#, TypeScript, Java, etc.).

## Architecture

### Core Components

1. **ServiceStack::JsonServiceClient**
   - Main client class for making HTTP requests
   - Supports all HTTP methods (GET, POST, PUT, DELETE, PATCH)
   - Handles JSON serialization/deserialization
   - Route resolution from request DTOs
   - Query string building for GET/DELETE requests

2. **ServiceStack::ServiceClientBase**
   - Base class providing core HTTP functionality
   - Authentication management (Basic and Bearer Token)
   - Request creation and configuration
   - Response handling
   - Error response processing

3. **ServiceStack::ResponseStatus**
   - DTO representing ServiceStack error responses
   - Contains error code, message, stack trace, and field errors
   - Matches ServiceStack's ResponseStatus format

4. **ServiceStack::WebServiceException**
   - Custom exception for ServiceStack errors
   - Includes HTTP status code, error code, and response details
   - Provides easy access to error information

## Features

### Request/Response Handling

- **Typed DTOs**: Support for Ruby classes with `to_hash` method
- **Hash-based requests**: Can use plain hashes for simple requests
- **Response type conversion**: Automatic instantiation of response objects
- **JSON serialization**: Automatic conversion to/from JSON

### HTTP Methods

All standard HTTP methods are supported:
- `GET` - Query string parameters
- `POST` - JSON body
- `PUT` - JSON body
- `DELETE` - Query string parameters
- `PATCH` - JSON body

### Authentication

- **Basic Authentication**: Username/password via `set_credentials`
- **Bearer Token**: Token-based auth via `set_bearer_token`
- **Custom Headers**: Arbitrary headers via `headers` hash

### Error Handling

- ServiceStack error responses are parsed and raised as `WebServiceException`
- Full error details including error code, message, and field errors
- HTTP status codes are preserved
- Non-JSON error responses are handled gracefully

### Configuration

- **Base URL**: Configurable API endpoint
- **Timeout**: Request timeout in seconds (default: 60)
- **Headers**: Custom headers dictionary

## Usage Patterns

### Basic Usage

```ruby
require 'servicestack'

client = ServiceStack::JsonServiceClient.new('https://api.example.org')
response = client.post({ name: 'World' }, path: '/hello')
```

### Typed DTOs

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

request = Hello.new(name: 'World')
response = client.post(request, HelloResponse, path: '/hello')
puts response.result
```

### Authentication

```ruby
# Basic Auth
client.set_credentials('username', 'password')

# Bearer Token
client.set_bearer_token('your-token')
```

### Error Handling

```ruby
begin
  response = client.post(request)
rescue ServiceStack::WebServiceException => e
  puts "Error: #{e.error_message}"
  puts "Code: #{e.error_code}"
  puts "Status: #{e.status_code}"
end
```

## Testing

The implementation includes a comprehensive test suite using:
- **MiniTest**: Ruby's standard testing framework
- **WebMock**: HTTP request stubbing for isolated tests

Test coverage includes:
- Client initialization
- Authentication methods
- All HTTP verbs
- Error handling
- Typed request/response
- Custom headers
- Query string parameters

## File Structure

```
servicestack-ruby/
├── lib/
│   ├── servicestack.rb                      # Main entry point
│   └── servicestack/
│       ├── version.rb                       # Version constant
│       ├── json_service_client.rb           # Main client class
│       ├── service_client_base.rb           # Base HTTP client
│       ├── response_status.rb               # Error response DTO
│       └── web_service_exception.rb         # Exception class
├── test/
│   └── test_json_service_client.rb          # Test suite
├── examples/
│   ├── basic_usage.rb                       # Basic example
│   ├── hello_world.rb                       # Simple hello example
│   ├── authentication.rb                    # Auth examples
│   ├── typed_dtos.rb                        # DTO examples
│   └── error_handling.rb                    # Error handling examples
├── servicestack-client.gemspec              # Gem specification
├── Gemfile                                  # Dependencies
├── Rakefile                                 # Rake tasks
├── README.md                                # User documentation
├── CHANGELOG.md                             # Version history
└── LICENSE                                  # BSD-3-Clause license
```

## Dependencies

Runtime dependencies:
- `json` (~> 2.0) - JSON parsing and generation

Development dependencies:
- `minitest` (~> 5.0) - Testing framework
- `webmock` (~> 3.0) - HTTP stubbing
- `rake` (~> 13.0) - Build tool

## Compatibility

- Ruby >= 2.6.0
- Compatible with all ServiceStack services
- Follows ServiceStack conventions and patterns

## Future Enhancements

Potential future additions:
- Server-Sent Events (SSE) support
- WebSocket support
- Retry logic with exponential backoff
- Request/response interceptors
- Automatic DTO generation from ServiceStack metadata
- Connection pooling
- Compression support (gzip)

## Security Considerations

- HTTPS is supported (automatically detected from URL scheme)
- Credentials are not logged or exposed
- Bearer tokens are transmitted via Authorization header
- No security vulnerabilities detected by CodeQL analysis

## Standards Compliance

- Follows Ruby gem conventions
- Uses semantic versioning
- Includes comprehensive documentation
- MIT/BSD-compatible licensing
- Tested and validated
