# ServiceStack Ruby Client

Ruby client library for [ServiceStack](https://servicestack.net/) - a simple, fast, versatile and highly productive full-featured Web and Web Services Framework.
ServiceStack Ruby HTTP Client Library for consuming ServiceStack web services.

[![Gem Version](https://badge.fury.io/rb/servicestack.svg)](https://badge.fury.io/rb/servicestack)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'servicestack'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install servicestack

## Usage

### Basic Usage

```ruby
require 'servicestack'

# Create a client instance
client = ServiceStack::Client.new('https://api.example.com')

# Make a GET request
response = client.get('users')

# Make a POST request
response = client.post('users', { name: 'John Doe', email: 'john@example.com' })

# Make a PUT request
response = client.put('users/1', { name: 'Jane Doe' })

# Make a PATCH request
response = client.patch('users/1', { email: 'jane@example.com' })

# Make a DELETE request
response = client.delete('users/1')
```

### With Query Parameters

```ruby
# GET request with query parameters
response = client.get('users', { page: 1, per_page: 10 })
```

### Configuring Timeouts

```ruby
# Configure custom timeouts (in seconds)
client = ServiceStack::Client.new(
  'https://api.example.com',
  timeout: 30,        # Request timeout
  open_timeout: 15    # Connection timeout
)

# Or set timeouts after initialization
client.timeout = 30
client.open_timeout = 15
```

### Error Handling

The client raises `ServiceStack::Error` for HTTP errors:

```ruby
begin
  response = client.get('users/999')
rescue ServiceStack::Error => e
  puts "Error: #{e.message}"
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

### Running Tests

```bash
bundle exec rake test
```

### Building the Gem

```bash
bundle exec rake build
```

This will create a `.gem` file in the `pkg` directory.

### Releasing

To release a new version:

1. Update the version number in `lib/servicestack/version.rb`
2. Update the `CHANGELOG.md` with the changes
3. Commit the changes
4. Run `bundle exec rake release` to create a git tag, build the gem, and push it to RubyGems

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ServiceStack/servicestack-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
