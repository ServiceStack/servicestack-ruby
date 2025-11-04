#!/usr/bin/env ruby
require_relative '../lib/servicestack'

# Example DTOs
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

# Usage example
def main
  # Create a client pointing to a ServiceStack API
  # Using the public ServiceStack test API
  client = ServiceStack::JsonServiceClient.new('https://test.servicestack.net')

  # Create and send request
  request = Hello.new(name: 'World')
  
  begin
    response = client.get(request, HelloResponse)
    puts "Response: #{response.result}"
  rescue ServiceStack::WebServiceException => e
    puts "Error: #{e.error_message}"
    puts "Status: #{e.status_code}"
  end
end

main if __FILE__ == $PROGRAM_NAME
