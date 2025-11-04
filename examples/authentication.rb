#!/usr/bin/env ruby
require_relative '../lib/servicestack'

# Example showing authentication with ServiceStack

# Define DTOs
class Authenticate
  attr_accessor :provider, :user_name, :password, :remember_me

  def initialize(hash = {})
    @provider = hash['provider'] || hash[:provider] || 'credentials'
    @user_name = hash['userName'] || hash[:user_name]
    @password = hash['password'] || hash[:password]
    @remember_me = hash['rememberMe'] || hash[:remember_me]
  end

  def to_hash
    {
      'provider' => @provider,
      'userName' => @user_name,
      'password' => @password,
      'rememberMe' => @remember_me
    }
  end
end

class AuthenticateResponse
  attr_accessor :user_id, :session_id, :user_name, :bearer_token

  def initialize(hash = {})
    @user_id = hash['userId'] || hash[:user_id]
    @session_id = hash['sessionId'] || hash[:session_id]
    @user_name = hash['userName'] || hash[:user_name]
    @bearer_token = hash['bearerToken'] || hash[:bearer_token]
  end
end

def example_basic_auth
  puts "=== Basic Authentication Example ==="
  
  client = ServiceStack::JsonServiceClient.new('https://example.org')
  client.set_credentials('username', 'password')
  
  # Make authenticated request
  # response = client.post(request)
  
  puts "Client configured with basic auth credentials"
end

def example_bearer_token
  puts "\n=== Bearer Token Authentication Example ==="
  
  # First authenticate to get a token
  client = ServiceStack::JsonServiceClient.new('https://example.org')
  
  begin
    auth_request = Authenticate.new(
      user_name: 'user@example.com',
      password: 'password123'
    )
    
    # Authenticate and get bearer token
    # auth_response = client.post(auth_request, AuthenticateResponse, path: '/auth')
    
    # Use bearer token for subsequent requests
    # client.set_bearer_token(auth_response.bearer_token)
    
    puts "Client configured with bearer token"
  rescue ServiceStack::WebServiceException => e
    puts "Authentication failed: #{e.error_message}"
  end
end

def example_custom_headers
  puts "\n=== Custom Headers Example ==="
  
  client = ServiceStack::JsonServiceClient.new('https://example.org')
  
  # Add custom headers
  client.headers['X-API-Key'] = 'your-api-key'
  client.headers['X-Custom-Header'] = 'custom-value'
  
  puts "Client configured with custom headers"
end

# Run examples
if __FILE__ == $PROGRAM_NAME
  example_basic_auth
  example_bearer_token
  example_custom_headers
end
