#!/usr/bin/env ruby
require_relative '../lib/servicestack'

# Example showing how to define and use typed DTOs with ServiceStack

# Define Request DTOs
class CreateUser
  attr_accessor :name, :email, :age

  def initialize(hash = {})
    @name = hash['name'] || hash[:name]
    @email = hash['email'] || hash[:email]
    @age = hash['age'] || hash[:age]
  end

  def to_hash
    {
      'name' => @name,
      'email' => @email,
      'age' => @age
    }
  end
end

class GetUser
  attr_accessor :id

  def initialize(hash = {})
    @id = hash['id'] || hash[:id]
  end

  def to_hash
    { 'id' => @id }
  end
end

class UpdateUser
  attr_accessor :id, :name, :email, :age

  def initialize(hash = {})
    @id = hash['id'] || hash[:id]
    @name = hash['name'] || hash[:name]
    @email = hash['email'] || hash[:email]
    @age = hash['age'] || hash[:age]
  end

  def to_hash
    {
      'id' => @id,
      'name' => @name,
      'email' => @email,
      'age' => @age
    }
  end
end

# Define Response DTOs
class UserResponse
  attr_accessor :id, :name, :email, :age, :created_date

  def initialize(hash = {})
    @id = hash['id'] || hash[:id]
    @name = hash['name'] || hash[:name]
    @email = hash['email'] || hash[:email]
    @age = hash['age'] || hash[:age]
    @created_date = hash['createdDate'] || hash[:created_date]
  end
end

class UsersResponse
  attr_accessor :users, :total

  def initialize(hash = {})
    @users = (hash['users'] || hash[:users] || []).map { |u| UserResponse.new(u) }
    @total = hash['total'] || hash[:total]
  end
end

# Usage examples
def example_create_user(client)
  puts "=== Creating a user ==="
  
  request = CreateUser.new(
    name: 'John Doe',
    email: 'john@example.com',
    age: 30
  )
  
  begin
    response = client.post(request, UserResponse, path: '/users')
    puts "Created user with ID: #{response.id}"
    puts "Name: #{response.name}, Email: #{response.email}"
  rescue ServiceStack::WebServiceException => e
    puts "Error: #{e.error_message}"
  end
end

def example_get_user(client, user_id)
  puts "\n=== Getting a user ==="
  
  request = GetUser.new(id: user_id)
  
  begin
    response = client.get(request, UserResponse, path: "/users/#{user_id}")
    puts "User: #{response.name} (#{response.email})"
  rescue ServiceStack::WebServiceException => e
    puts "Error: #{e.error_message}"
  end
end

def example_update_user(client, user_id)
  puts "\n=== Updating a user ==="
  
  request = UpdateUser.new(
    id: user_id,
    name: 'Jane Doe',
    email: 'jane@example.com',
    age: 31
  )
  
  begin
    response = client.put(request, UserResponse, path: "/users/#{user_id}")
    puts "Updated user: #{response.name}"
  rescue ServiceStack::WebServiceException => e
    puts "Error: #{e.error_message}"
  end
end

# Run examples (commented out since we can't connect to a real server)
if __FILE__ == $PROGRAM_NAME
  # client = ServiceStack::JsonServiceClient.new('https://api.example.org')
  # client.set_bearer_token('your-token')
  
  # example_create_user(client)
  # example_get_user(client, 1)
  # example_update_user(client, 1)
  
  puts "This example shows how to define typed DTOs for ServiceStack"
  puts "Uncomment the code above to run with a real ServiceStack API"
end
