# frozen_string_literal: true

require_relative 'test_helper'

class TestJsonServiceClient < Minitest::Test
  include TestHelper

  def test_sends_get_request_in_query_string
    stub_request(:get, "#{BASE_URL}/api/Hello?name=World")
      .to_return(body: { result: 'Hello, World!' }.to_json)

    res = client.send(Hello.new(name: 'World'))

    assert_instance_of HelloResponse, res
    assert_equal 'Hello, World!', res.result
  end

  def test_sends_post_request_in_json_body
    stub_request(:post, "#{BASE_URL}/api/CreateHello")
      .with(body: '{"name":"World"}', headers: { 'Content-Type' => 'application/json' })
      .to_return(body: { result: 'Hello, World!' }.to_json)

    res = client.send(CreateHello.new(name: 'World'))

    assert_equal 'Hello, World!', res.result
  end

  def test_sends_typed_query_response
    stub_request(:get, "#{BASE_URL}/api/QueryBookings?take=2")
      .to_return(body: {
        offset: 0, total: 1,
        results: [{
          id: 1, name: 'First Booking', bookingStartDate: '2025-10-31T06:05:01Z',
          createdBy: 'employee@email.com',
          discount: { id: 'BOOK10', description: '10% off' },
        }],
      }.to_json)

    res = client.send(QueryBookings.new(take: 2))

    assert_equal 1, res.total
    booking = res.results.first
    assert_instance_of Booking, booking
    assert_equal 'First Booking', booking.name
    # nested DTOs, inherited properties and Dates are converted from their wire names
    assert_instance_of Coupon, booking.discount
    assert_equal '10% off', booking.discount.description
    assert_equal 'employee@email.com', booking.created_by
    assert_instance_of DateTime, booking.booking_start_date
    assert_equal 2025, booking.booking_start_date.year
  end

  def test_sends_void_request
    stub_request(:delete, "#{BASE_URL}/api/DeleteHello?id=1").to_return(body: '')

    assert_nil client.send_void(DeleteHello.new(id: 1))
  end

  def test_raises_web_service_exception_with_structured_error
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .to_return(status: [400, 'Bad Request'], body: error_body)

    error = assert_raises(ServiceStack::WebServiceException) { client.send(Hello.new) }

    assert_equal 400, error.status_code
    assert_equal 'NotEmpty', error.error_code
    assert_equal "'Name' must not be empty.", error.error_message
    assert_equal "'Name' must not be empty.", error.field_error('name')
    assert error.validation_error?
    refute error.unauthorized?
  end

  def test_raises_web_service_exception_for_non_json_errors
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .to_return(status: [404, 'Not Found'], body: '<html>Not Found</html>')

    error = assert_raises(ServiceStack::WebServiceException) { client.send(Hello.new) }

    assert error.not_found?
    assert_equal '<html>Not Found</html>', error.response_body
  end

  def test_api_returns_error_status_instead_of_raising
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .to_return(status: [400, 'Bad Request'], body: error_body)

    api = client.api(Hello.new)

    assert api.failed?
    assert_equal 'NotEmpty', api.error_code
    assert_equal "'Name' must not be empty.", api.field_error('Name')
  end

  def test_api_returns_typed_response
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .to_return(body: { result: 'Hello, World!' }.to_json)

    api = client.api(Hello.new(name: 'World'))

    assert api.succeeded?
    assert_equal 'Hello, World!', api.response.result
    assert_nil api.field_error('Name')
  end

  def test_sends_bearer_token_and_basic_auth
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with(headers: { 'Authorization' => 'Bearer TOKEN' })
      .to_return(body: '{}')

    client.set_bearer_token('TOKEN')
    client.send(Hello.new(name: 'World'))

    basic = ServiceStack::JsonServiceClient.new(BASE_URL)
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with(headers: { 'Authorization' => 'Basic dXNlcjpwYXNz' })
      .to_return(body: '{}')

    basic.set_credentials('user', 'pass')
    basic.send(Hello.new(name: 'World'))
  end

  def test_sends_custom_headers
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with(headers: { 'X-Api-Key' => 'KEY' })
      .to_return(body: '{}')

    client.set_header('X-Api-Key', 'KEY')
    client.send(Hello.new(name: 'World'))
  end

  def test_refreshes_bearer_token_and_retries
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with { |req| req.headers['Authorization'].nil? }
      .to_return(status: [401, 'Unauthorized'], body: error_body('Unauthorized', 'Unauthorized'))

    stub_request(:post, "#{BASE_URL}/api/GetAccessToken")
      .to_return(body: { accessToken: 'NEW_TOKEN' }.to_json)

    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with(headers: { 'Authorization' => 'Bearer NEW_TOKEN' })
      .to_return(body: { result: 'Hello, World!' }.to_json)

    client.set_refresh_token('REFRESH_TOKEN')
    res = client.send(Hello.new(name: 'World'))

    assert_equal 'Hello, World!', res.result
    assert_equal 'NEW_TOKEN', client.bearer_token
  end

  def test_unauthorized_without_refresh_token_raises
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .to_return(status: [401, 'Unauthorized'], body: error_body('Unauthorized', 'Unauthorized'))

    error = assert_raises(ServiceStack::WebServiceException) { client.send(Hello.new) }

    assert error.unauthorized?
  end

  def test_sends_batched_requests
    stub_request(:post, "#{BASE_URL}/api/Hello[]")
      .with(body: '[{"name":"A"},{"name":"B"}]')
      .to_return(body: [{ result: 'Hello, A!' }, { result: 'Hello, B!' }].to_json)

    responses = client.send_all([Hello.new(name: 'A'), Hello.new(name: 'B')])

    assert_equal 2, responses.size
    assert_instance_of HelloResponse, responses.first
    assert_equal 'Hello, B!', responses.last.result
  end

  def test_publishes_one_way_request
    stub_request(:post, "#{BASE_URL}/api/CreateHello").to_return(body: '')

    assert_nil client.publish(CreateHello.new(name: 'World'))
  end

  def test_sends_request_to_custom_url
    stub_request(:get, "#{BASE_URL}/hello/World?detailed=true")
      .to_return(body: { result: 'Hello, World!' }.to_json)

    res = client.get_url('/hello/World', response_as: HelloResponse, args: { detailed: true })

    assert_equal 'Hello, World!', res.result
  end

  def test_returns_raw_response_body
    stub_request(:get, "#{BASE_URL}/text").to_return(body: 'plain text')

    assert_equal 'plain text', client.send_url_string('/text')
  end

  def test_retains_session_cookies
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .to_return(body: '{}', headers: { 'Set-Cookie' => 'ss-id=SESSION_ID; path=/; httponly' })
    client.send(Hello.new(name: '1'))

    assert_equal 'SESSION_ID', client.cookies['ss-id']

    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with(headers: { 'Cookie' => 'ss-id=SESSION_ID' })
      .to_return(body: '{}')
    client.send(Hello.new(name: '2'))
  end

  def test_authenticate_uses_returned_tokens
    stub_request(:post, "#{BASE_URL}/api/Authenticate")
      .to_return(body: { userName: 'user', bearerToken: 'BEARER', refreshToken: 'REFRESH' }.to_json)

    res = client.authenticate('user', 'pass')

    assert_equal 'user', res.user_name
    assert_equal 'BEARER', client.bearer_token
    assert_equal 'REFRESH', client.refresh_token
  end

  def test_configures_base_paths
    assert_equal "#{BASE_URL}/api", client.reply_base_url

    client.set_base_path('')
    assert_equal "#{BASE_URL}/json/reply", client.reply_base_url
    assert_equal "#{BASE_URL}/json/oneway", client.oneway_base_url

    client.set_base_path('custom/api')
    assert_equal "#{BASE_URL}/custom/api", client.reply_base_url
  end

  def test_on_authentication_required_retries_once
    requests = 0
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with { |req| requests += 1; req.headers['Authorization'].nil? }
      .to_return(status: [401, 'Unauthorized'], body: error_body('Unauthorized', 'Unauthorized'))

    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with(headers: { 'Authorization' => 'Bearer TOKEN' })
      .to_return(body: { result: 'Authenticated' }.to_json)

    client.on_authentication_required = ->(c) { c.set_bearer_token('TOKEN') }
    res = client.send(Hello.new(name: 'World'))

    assert_equal 'Authenticated', res.result
    assert_equal 1, requests
  end

  def test_on_authentication_required_supports_zero_arity_callbacks
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with { |req| req.headers['Authorization'].nil? }
      .to_return(status: [401, 'Unauthorized'], body: error_body('Unauthorized', 'Unauthorized'))

    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with(headers: { 'Authorization' => 'Bearer TOKEN' })
      .to_return(body: { result: 'Authenticated' }.to_json)

    called = false
    client.on_authentication_required = lambda {
      called = true
      client.set_bearer_token('TOKEN')
    }
    res = client.send(Hello.new(name: 'World'))

    assert called
    assert_equal 'Authenticated', res.result
  end

  def test_on_authentication_required_failure_returns_original_401
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .to_return(status: [401, 'Unauthorized'], body: error_body('Unauthorized', 'Unauthorized'))

    client.on_authentication_required = ->(_c) { raise 'auth server down' }
    error = assert_raises(ServiceStack::WebServiceException) { client.send(Hello.new) }

    assert error.unauthorized?
    assert_equal 'Unauthorized', error.error_code
  end

  def test_refresh_token_takes_precedence_over_callback
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with { |req| req.headers['Authorization'].nil? }
      .to_return(status: [401, 'Unauthorized'], body: error_body('Unauthorized', 'Unauthorized'))

    stub_request(:post, "#{BASE_URL}/api/GetAccessToken")
      .to_return(body: { accessToken: 'REFRESHED' }.to_json)

    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .with(headers: { 'Authorization' => 'Bearer REFRESHED' })
      .to_return(body: { result: 'Hello, World!' }.to_json)

    called = false
    client.set_refresh_token('REFRESH_TOKEN')
    client.on_authentication_required = ->(_c) { called = true }

    res = client.send(Hello.new(name: 'World'))

    assert_equal 'Hello, World!', res.result
    assert_equal 'REFRESHED', client.bearer_token
    refute called, 'expected the Refresh Token to be used instead of the callback'
  end

  def test_raises_for_unfollowed_redirects
    stub_request(:get, %r{#{BASE_URL}/api/Hello})
      .to_return(status: [302, 'Found'], headers: { 'Location' => '/Account/Login' }, body: '')

    error = assert_raises(ServiceStack::WebServiceException) { client.send(Hello.new) }

    assert_equal 302, error.status_code
    assert_equal 'Redirect', error.error_code
    assert_includes error.error_message, '/Account/Login'
  end

  def test_raises_for_connection_errors
    stub_request(:get, %r{#{BASE_URL}/api/Hello}).to_raise(Errno::ECONNREFUSED)

    error = assert_raises(ServiceStack::WebServiceException) { client.send(Hello.new) }

    assert_instance_of Errno::ECONNREFUSED, error.inner_exception
  end
end
