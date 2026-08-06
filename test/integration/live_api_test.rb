# frozen_string_literal: true

# Integration tests against the live https://test.servicestack.net Services:
#
#   rake test:integration
#
# Use SERVICESTACK_TEST_URL to run them against a different ServiceStack instance.

$LOAD_PATH.unshift File.expand_path('../../lib', __dir__)

require 'servicestack'
require 'minitest/autorun'

# Hand-written DTOs matching the remote Services, generated DTOs have the same shape.

class IntegrationHelloResponse
  include ServiceStack::DTO
  attr_accessor :result

  def self.properties = { result: { name: 'result' } }
end

class IntegrationHello
  include ServiceStack::DTO
  attr_accessor :name

  def self.properties = { name: { name: 'name' } }

  def response_type = IntegrationHelloResponse
  def get_type_name = 'Hello'
  def get_method = 'GET'
end

class ThrowValidationResponse
  include ServiceStack::DTO
  attr_accessor :age, :email, :response_status

  def self.properties
    {
      age: { name: 'age' },
      email: { name: 'email' },
      response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
    }
  end
end

class ThrowValidation
  include ServiceStack::DTO
  attr_accessor :age, :email

  def self.properties
    {
      age: { name: 'age' },
      email: { name: 'email' },
    }
  end

  def response_type = ThrowValidationResponse
  def get_type_name = 'ThrowValidation'
  def get_method = 'POST'
end

class ThrowTypeResponse
  include ServiceStack::DTO
  attr_accessor :response_status

  def self.properties
    { response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus } }
  end
end

class ThrowType
  include ServiceStack::DTO
  attr_accessor :type, :message

  def self.properties
    {
      type: { name: 'type' },
      message: { name: 'message' },
    }
  end

  def response_type = ThrowTypeResponse
  def get_type_name = 'ThrowType'
  def get_method = 'GET'
end

class HelloSecure
  include ServiceStack::DTO
  attr_accessor :name

  def self.properties = { name: { name: 'name' } }

  def response_type = IntegrationHelloResponse
  def get_type_name = 'HelloSecure'
  def get_method = 'GET'
end

class LiveApiTest < Minitest::Test
  def base_url
    ENV['SERVICESTACK_TEST_URL'] || 'https://test.servicestack.net'
  end

  def client
    @client ||= ServiceStack::JsonServiceClient.new(base_url)
  end

  def test_sends_typed_request
    res = client.send(IntegrationHello.new(name: 'World'))

    assert_equal 'Hello, World!', res.result
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
    responses = client.send_all([IntegrationHello.new(name: 'A'), IntegrationHello.new(name: 'B')])

    assert_equal 2, responses.size
    assert_equal 'Hello, A!', responses.first.result
    assert_equal 'Hello, B!', responses.last.result
  end

  def test_sends_request_to_custom_route
    res = client.get_url('/hello/World', response_as: IntegrationHelloResponse)

    assert_equal 'Hello, World!', res.result
  end
end

# ── AI Chat ──

# DTOs of ServiceStack's AI Chat ChatCompletion API, an OpenAI-compatible
# Chat Completions endpoint.

class AiTextContent
  include ServiceStack::DTO
  attr_accessor :type, :text

  def self.properties
    {
      type: { name: 'type' },
      text: { name: 'text' },
    }
  end
end

class AiMessage
  include ServiceStack::DTO
  attr_accessor :role, :content

  def self.properties
    {
      role: { name: 'role' },
      content: { name: 'content' },
    }
  end
end

class ChoiceMessage
  include ServiceStack::DTO
  attr_accessor :role, :content, :reasoning

  def self.properties
    {
      role: { name: 'role' },
      content: { name: 'content' },
      reasoning: { name: 'reasoning' },
    }
  end
end

class Choice
  include ServiceStack::DTO
  attr_accessor :index, :finish_reason, :message

  def self.properties
    {
      index: { name: 'index' },
      finish_reason: { name: 'finish_reason' },
      message: { name: 'message', type: ChoiceMessage },
    }
  end
end

class ChatResponse
  include ServiceStack::DTO
  attr_accessor :id, :model, :choices

  def self.properties
    {
      id: { name: 'id' },
      model: { name: 'model' },
      choices: { name: 'choices', type: [Choice] },
    }
  end
end

class ChatCompletion
  include ServiceStack::DTO
  attr_accessor :model, :messages

  def self.properties
    {
      model: { name: 'model' },
      messages: { name: 'messages', type: [AiMessage] },
    }
  end

  def response_type = ChatResponse
  def get_type_name = 'ChatCompletion'
  def get_method = 'POST'
end

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
