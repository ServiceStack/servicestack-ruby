require 'minitest/autorun'
require 'webmock/minitest'
require_relative '../lib/servicestack'

class TestJsonServiceClient < Minitest::Test
  def setup
    @base_url = 'https://api.example.org'
    @client = ServiceStack::JsonServiceClient.new(@base_url)
  end

  def test_client_initialization
    assert_equal 'https://api.example.org', @client.base_url
    assert_equal 60, @client.timeout
  end

  def test_set_credentials
    @client.set_credentials('user', 'pass')
    assert_equal 'user', @client.username
    assert_equal 'pass', @client.password
  end

  def test_set_bearer_token
    @client.set_bearer_token('token123')
    assert_equal 'token123', @client.bearer_token
  end

  def test_post_request_with_hash
    stub_request(:post, "#{@base_url}/hello")
      .with(
        body: '{"name":"World"}',
        headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      )
      .to_return(status: 200, body: '{"result":"Hello, World!"}', headers: { 'Content-Type' => 'application/json' })

    response = @client.post({ name: 'World' }, nil, path: '/hello')
    assert_equal 'Hello, World!', response['result']
  end

  def test_get_request_with_query_params
    stub_request(:get, "#{@base_url}/hello?name=World")
      .with(headers: { 'Accept' => 'application/json' })
      .to_return(status: 200, body: '{"result":"Hello, World!"}', headers: { 'Content-Type' => 'application/json' })

    response = @client.get({ name: 'World' }, nil, path: '/hello')
    assert_equal 'Hello, World!', response['result']
  end

  def test_error_handling
    stub_request(:post, "#{@base_url}/hello")
      .to_return(
        status: 400,
        body: '{"responseStatus":{"errorCode":"ValidationError","message":"Name is required"}}',
        headers: { 'Content-Type' => 'application/json' }
      )

    error = assert_raises(ServiceStack::WebServiceException) do
      @client.post({ name: '' }, nil, path: '/hello')
    end

    assert_equal 400, error.status_code
    assert_equal 'ValidationError', error.error_code
    assert_equal 'Name is required', error.error_message
  end

  def test_bearer_token_authentication
    @client.set_bearer_token('mytoken')

    stub_request(:post, "#{@base_url}/secure")
      .with(headers: { 'Authorization' => 'Bearer mytoken' })
      .to_return(status: 200, body: '{"success":true}')

    response = @client.post({ data: 'test' }, nil, path: '/secure')
    assert response['success']
  end

  def test_custom_headers
    @client.headers['X-Custom'] = 'value'

    stub_request(:post, "#{@base_url}/hello")
      .with(headers: { 'X-Custom' => 'value' })
      .to_return(status: 200, body: '{"result":"ok"}')

    response = @client.post({ name: 'test' }, nil, path: '/hello')
    assert_equal 'ok', response['result']
  end

  def test_typed_request_response
    # Define named classes for the test
    hello_request_class = Class.new do
      attr_accessor :name
      
      def initialize(name)
        @name = name
      end
      
      def to_hash
        { 'name' => @name }
      end
      
      def self.name
        'Hello'
      end
    end

    hello_response_class = Class.new do
      attr_accessor :result
      
      def initialize(hash)
        @result = hash['result']
      end
    end

    stub_request(:post, "#{@base_url}/hello")
      .to_return(status: 200, body: '{"result":"Hello, Ruby!"}')

    request = hello_request_class.new('Ruby')
    response = @client.post(request, hello_response_class)
    assert_equal 'Hello, Ruby!', response.result
  end
end
