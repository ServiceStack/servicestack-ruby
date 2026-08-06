# servicestack-ruby

Typed Ruby Client Library for consuming [ServiceStack](https://servicestack.net) APIs.

- Typed Request/Response DTOs, generated from any ServiceStack API
- Response Type, route and HTTP Method resolved from the Request DTO
- Structured `ResponseStatus` errors with field validation errors
- Auth with Basic Auth, API Keys, JWT Bearer Tokens, Refresh Tokens and Session Cookies
- Batched Requests, one-way Requests and custom URLs
- Zero dependencies, only the Ruby standard library

Requires Ruby 3.0+.

## Install

```bash
gem install servicestack
```

Or in your `Gemfile`:

```ruby
gem 'servicestack'
```

## Generate Typed DTOs

Generate the Ruby DTOs of any ServiceStack API with the [get-dtos](https://www.npmjs.com/package/get-dtos) tool:

```bash
npx get-dtos ruby https://blazor-vue.web-templates.io
```

Which downloads a `dtos.rb` containing the typed DTOs of the remote API:

```ruby
require 'json'
require 'servicestack'

# @Route("/hello/{Name}")
class Hello
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = HelloResponse
    def get_type_name() = 'Hello'
    def get_method() = 'GET'
end
```

The generated `response_type`, `get_type_name` and `get_method` are what let the
client resolve each API's Response Type, route and HTTP Method, whilst
`self.properties` declares the wire name and Type of each property so nested
DTOs, Dates and collections round-trip correctly.

## Usage

```ruby
require 'servicestack'
require_relative 'dtos'

client = ServiceStack::JsonServiceClient.new('https://blazor-vue.web-templates.io')

res = client.send(Hello.new(name: 'World')) # res is a HelloResponse
puts res.result
```

`send` uses the HTTP Method the API is annotated with, use `get`, `post`, `put`,
`patch` or `delete` to send a Request DTO with a specific HTTP Method:

```ruby
res = client.post(Hello.new(name: 'World'))
```

APIs that don't return a Response Body are sent with `send_void`:

```ruby
client.send_void(DeleteBooking.new(id: 1))
```

> `JsonServiceClient#send` overrides `Object#send`. Use `__send__` for Ruby's
> dynamic dispatch, or `send_dto` if you prefer an unambiguous name.

### AutoQuery

AutoQuery APIs return a typed `QueryResponse`, with the query params of their
base type inherited by the Request DTO:

```ruby
res = client.send(QueryBookings.new(take: 5, order_by_desc: 'id'))

res.results.each do |booking| # booking is a Booking
  puts "#{booking.id} #{booking.name}"
end
```

### Error Handling

Failed API Requests raise a `WebServiceException` containing the HTTP Status
Code and the API's structured `ResponseStatus`:

```ruby
begin
  client.send(CreateBooking.new)
rescue ServiceStack::WebServiceException => e
  puts e.status_code            # 400
  puts e.error_code             # "NotEmpty"
  puts e.error_message          # "'Name' must not be empty."
  puts e.field_error('Name')    # "'Name' must not be empty."
  puts e.unauthorized?          # false
end
```

Alternatively `api` returns errors in its result instead of raising:

```ruby
api = client.api(CreateBooking.new)
if api.failed?
  puts api.error_code, api.field_error('Name')
else
  puts api.response.id
end
```

Redirects aren't followed, so Services that redirect to a HTML sign in page
raise a `WebServiceException` with a `Redirect` ErrorCode instead of returning
an empty Response.

### Authentication

API Keys and JWTs are sent in the Bearer Token Authorization header:

```ruby
client.set_bearer_token('ak-87949de37e894627a9f6173154e7cafa')
```

HTTP Basic Auth credentials:

```ruby
client.set_credentials('username', 'password')
```

Sign in with ServiceStack's Authenticate API, which retains the Session Cookies
the Server returns and uses any Bearer Token it issues:

```ruby
auth = client.authenticate('username', 'password')
```

When a Refresh Token is configured, expired Bearer Tokens are transparently
refreshed and the failed Request retried:

```ruby
client.set_refresh_token(refresh_token)
```

### Transparently handle 401 Unauthorized Responses

If the Server returns a 401 Unauthorized Response either because the client was
unauthenticated or its Bearer Token or API Key had expired, use the
`on_authentication_required` callback to re-configure the client before the
original Request is automatically retried:

```ruby
client.on_authentication_required = lambda { |c|
  c.authenticate(user_name, password)
}

# Automatically retries Requests returning 401 Responses
res = client.send(Secured.new)
```

A configured Refresh Token takes precedence over the callback, which is only
used when no Refresh Token is set or refreshing it failed.

### Batched Requests

```ruby
responses = client.send_all([Hello.new(name: 'A'), Hello.new(name: 'B')])
```

Or send a Request to a one-way endpoint that ignores its Response:

```ruby
client.publish(Hello.new(name: 'World'))
```

### Uploading Files

Use `post_file_with_request` to upload a file with an API Request, whose contents
can be a String or any IO:

```ruby
res = File.open('photo.png', 'rb') do |file|
  client.post_file_with_request(UploadPhoto.new(album: 'Holiday'),
    ServiceStack::UploadFile.new(field_name: 'file', file_name: 'photo.png',
                                 content_type: 'image/png', stream: file))
end
```

The Request DTO's populated properties are sent as form fields alongside the file.
To upload multiple files use `post_files_with_request`.

### Custom URLs

```ruby
res = client.get_url('/hello/World', response_as: HelloResponse)
res = client.post_url('/hello', body: Hello.new(name: 'World'), response_as: HelloResponse)
csv = client.send_url_string('/api/QueryBookings.csv')
```

### Client Configuration

```ruby
client.set_header('X-Custom', 'Value')
client.timeout = 30
client.set_base_path('')  # use the /json/reply pre-defined routes

# Inspect or modify each Request and Response
client.request_filter = ->(req) { puts req.path }
client.response_filter = ->(res) { puts res.code }
```

## Tests

```bash
rake test              # unit tests
rake test:integration  # integration tests against test.servicestack.net
```

## Releasing

Releases are cut with npm scripts and published by the `release` GitHub Action:

```bash
npm run bump              # 0.1.0 -> 0.1.1 (also `-- minor`, `-- major`, `-- 1.2.3`)
# describe the release in CHANGELOG.md, then
npm run release
```

Or in a single step:

```bash
npm run release -- patch
```

`npm run release` tags the version, pushes it and creates the GitHub Release,
which triggers the workflow that runs the tests and publishes it to [RubyGems](https://rubygems.org/gems/servicestack).

## License

BSD-3-Clause. See [LICENSE](LICENSE).
