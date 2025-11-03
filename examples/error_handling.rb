#!/usr/bin/env ruby
require_relative '../lib/servicestack'

# Example showing error handling with ServiceStack

class ValidateUser
  attr_accessor :name, :email

  def initialize(hash = {})
    @name = hash['name'] || hash[:name]
    @email = hash['email'] || hash[:email]
  end

  def to_hash
    { 'name' => @name, 'email' => @email }
  end
end

def example_validation_error
  puts "=== Validation Error Handling ==="
  
  client = ServiceStack::JsonServiceClient.new('https://api.example.org')
  
  # Send invalid data
  request = ValidateUser.new(name: '', email: 'invalid-email')
  
  begin
    response = client.post(request, path: '/validate')
    puts "Validation passed: #{response}"
  rescue ServiceStack::WebServiceException => e
    puts "Validation failed!"
    puts "  Status Code: #{e.status_code}"
    puts "  Error Code: #{e.error_code}"
    puts "  Message: #{e.error_message}"
    
    if e.response_status
      puts "\nDetailed errors:"
      e.response_status.errors.each do |error|
        puts "  - #{error['fieldName']}: #{error['message']}"
      end
    end
  end
end

def example_authentication_error
  puts "\n=== Authentication Error Handling ==="
  
  client = ServiceStack::JsonServiceClient.new('https://api.example.org')
  # Not setting any auth credentials
  
  begin
    response = client.get({}, path: '/secure-resource')
    puts "Access granted: #{response}"
  rescue ServiceStack::WebServiceException => e
    case e.status_code
    when 401
      puts "Authentication required: #{e.error_message}"
    when 403
      puts "Access forbidden: #{e.error_message}"
    else
      puts "Error: #{e.error_message}"
    end
  end
end

def example_not_found_error
  puts "\n=== Not Found Error Handling ==="
  
  client = ServiceStack::JsonServiceClient.new('https://api.example.org')
  
  begin
    response = client.get({}, path: '/nonexistent')
    puts "Found: #{response}"
  rescue ServiceStack::WebServiceException => e
    if e.status_code == 404
      puts "Resource not found"
    else
      puts "Error: #{e.error_message} (#{e.status_code})"
    end
  end
end

def example_server_error
  puts "\n=== Server Error Handling ==="
  
  client = ServiceStack::JsonServiceClient.new('https://api.example.org')
  
  begin
    response = client.post({}, path: '/error-endpoint')
    puts "Success: #{response}"
  rescue ServiceStack::WebServiceException => e
    if e.status_code >= 500
      puts "Server error occurred"
      puts "  Status: #{e.status_code} - #{e.status_description}"
      puts "  Message: #{e.error_message}"
      
      # You might want to retry or log this
      puts "\nThis might be a temporary issue. Consider retrying."
    else
      puts "Client error: #{e.error_message}"
    end
  end
end

def example_generic_error_handling
  puts "\n=== Generic Error Handling Pattern ==="
  
  client = ServiceStack::JsonServiceClient.new('https://api.example.org')
  client.timeout = 30
  
  begin
    response = client.post({}, path: '/some-endpoint')
    puts "Success: #{response}"
  rescue ServiceStack::WebServiceException => e
    # ServiceStack-specific errors
    puts "ServiceStack Error:"
    puts "  HTTP Status: #{e.status_code}"
    puts "  Error Code: #{e.error_code}" if e.error_code
    puts "  Message: #{e.error_message}"
  rescue StandardError => e
    # Other errors (network, timeout, etc.)
    puts "Unexpected error: #{e.class.name}"
    puts "  Message: #{e.message}"
  end
end

# Run examples
if __FILE__ == $PROGRAM_NAME
  puts "ServiceStack Error Handling Examples"
  puts "=" * 50
  puts "\nNote: These examples show error handling patterns."
  puts "They won't actually run without a real ServiceStack API.\n"
  puts "=" * 50
  
  # Uncomment to run with a real API:
  # example_validation_error
  # example_authentication_error
  # example_not_found_error
  # example_server_error
  # example_generic_error_handling
  
  puts "\nError handling example code is ready to use!"
end
