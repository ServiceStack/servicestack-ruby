# frozen_string_literal: true

# Integration tests against the live https://test.servicestack.net Services:
#
#   rake test:integration
#
# Use SERVICESTACK_TEST_URL to run them against a different ServiceStack instance.

$LOAD_PATH.unshift File.expand_path('../../lib', __dir__)

require 'servicestack'
require 'minitest/autorun'

# Typed DTOs generated from https://test.servicestack.net with:
#   npx get-dtos ruby https://test.servicestack.net
require_relative '../dtos'

class LiveApiTest < Minitest::Test
  def base_url
    ENV['SERVICESTACK_TEST_URL'] || 'https://test.servicestack.net'
  end

  def client
    @client ||= ServiceStack::JsonServiceClient.new(base_url)
  end

  def test_sends_typed_request
    res = client.send(Hello.new(name: 'World', title: 'Mr'))

    assert_equal 'Hello, Mr. World!', res.result
  end

  def test_returns_validation_errors
    error = assert_raises(ServiceStack::WebServiceException) { client.send(ThrowValidation.new) }

    assert_equal 400, error.status_code
    assert error.validation_error?
    assert_includes error.field_error('Age'), 'must be between 1 and 120'
    refute_nil error.field_error('Email')
  end

  def test_returns_error_status_codes
    error = assert_raises(ServiceStack::WebServiceException) do
      client.send(ThrowType.new(type: 'NotFound', message: 'Not Here'))
    end

    assert error.not_found?
    assert_equal 'NotFound', error.error_code
    assert_equal 'Not Here', error.error_message
  end

  def test_api_returns_error_status
    api = client.api(HelloSecure.new(name: 'World'))

    assert api.failed?
    assert_equal 'Unauthorized', api.error_code
  end

  def test_authenticates_then_calls_secure_service
    auth = client.authenticate('test', 'test')

    assert_equal 'test', auth.user_name

    # The authenticated Session is maintained by the client's Session Cookies
    res = client.send(HelloSecure.new(name: 'World'))

    assert_equal 'Hello, World!', res.result
  end

  def test_sends_batched_requests
    responses = client.send_all([Hello.new(name: 'A'), Hello.new(name: 'B')])

    assert_equal 2, responses.size
    assert_equal 'Hello, A!', responses.first.result
    assert_equal 'Hello, B!', responses.last.result
  end

  def test_sends_request_to_custom_route
    res = client.get_url('/hello/World', response_as: HelloResponse)

    assert_equal 'Hello, World!', res.result
  end
end

# Sends a Request to ServiceStack AI Chat's OpenAI-compatible ChatCompletion API
class ChatCompletionTest < Minitest::Test
  # Model available on test.servicestack.net
  CHAT_MODEL = 'openai/gpt-oss-120b'

  def base_url
    ENV['SERVICESTACK_TEST_URL'] || 'https://test.servicestack.net'
  end

  def client
    @client ||= ServiceStack::JsonServiceClient.new(base_url)
  end

  def test_sends_chat_completion
    # The ChatCompletion API requires an authenticated User
    client.authenticate('test', 'test')

    request = ChatCompletion.new(
      model: CHAT_MODEL,
      messages: [
        AiMessage.new(
          role: 'user',
          # Content parts are polymorphic, e.g. text, image_url or input_audio
          content: [AiTextContent.new(type: 'text', text: 'Capital of France? Answer in 3 words')]
        )
      ]
    )

    begin
      res = client.send(request)
    rescue ServiceStack::WebServiceException => e
      # A shared LLM can be rate limited or temporarily unavailable
      skip("ChatCompletion unavailable: #{e.message}") if [429, 502, 503, 504].include?(e.status_code)
      raise
    end

    refute_empty res.choices
    assert_instance_of Choice, res.choices.first
    refute_nil res.choices.first.message.content
    refute_empty res.choices.first.message.content
    assert_equal CHAT_MODEL, res.model
  end
end
