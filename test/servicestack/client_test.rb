# frozen_string_literal: true

require "test_helper"

class ServiceStack::ClientTest < Minitest::Test
  def setup
    @client = ServiceStack::Client.new("https://api.example.com")
  end

  def test_initialize_with_base_url
    assert_equal "https://api.example.com", @client.base_url
  end

  def test_initialize_removes_trailing_slash
    client = ServiceStack::Client.new("https://api.example.com/")
    assert_equal "https://api.example.com", client.base_url
  end

  def test_initialize_with_timeout_options
    client = ServiceStack::Client.new("https://api.example.com", timeout: 30, open_timeout: 15)
    assert_equal 30, client.timeout
    assert_equal 15, client.open_timeout
  end

  def test_initialize_with_default_timeout
    assert_equal 60, @client.timeout
    assert_equal 60, @client.open_timeout
  end

  def test_get_request
    stub_request(:get, "https://api.example.com/users?page=1")
      .to_return(status: 200, body: '{"users": []}', headers: { "Content-Type" => "application/json" })

    response = @client.get("users", page: 1)
    assert_equal({ "users" => [] }, response)
  end

  def test_post_request
    stub_request(:post, "https://api.example.com/users")
      .with(body: '{"name":"John"}')
      .to_return(status: 200, body: '{"id": 1, "name": "John"}', headers: { "Content-Type" => "application/json" })

    response = @client.post("users", name: "John")
    assert_equal({ "id" => 1, "name" => "John" }, response)
  end

  def test_put_request
    stub_request(:put, "https://api.example.com/users/1")
      .with(body: '{"name":"Jane"}')
      .to_return(status: 200, body: '{"id": 1, "name": "Jane"}', headers: { "Content-Type" => "application/json" })

    response = @client.put("users/1", name: "Jane")
    assert_equal({ "id" => 1, "name" => "Jane" }, response)
  end

  def test_patch_request
    stub_request(:patch, "https://api.example.com/users/1")
      .with(body: '{"email":"jane@example.com"}')
      .to_return(status: 200, body: '{"id": 1, "email": "jane@example.com"}', headers: { "Content-Type" => "application/json" })

    response = @client.patch("users/1", email: "jane@example.com")
    assert_equal({ "id" => 1, "email" => "jane@example.com" }, response)
  end

  def test_delete_request
    stub_request(:delete, "https://api.example.com/users/1")
      .to_return(status: 200, body: '{"success": true}', headers: { "Content-Type" => "application/json" })

    response = @client.delete("users/1")
    assert_equal({ "success" => true }, response)
  end

  def test_error_handling_client_error
    stub_request(:get, "https://api.example.com/users/999")
      .to_return(status: 404, body: '{"error": "Not found"}', headers: { "Content-Type" => "application/json" })

    error = assert_raises(ServiceStack::Error) do
      @client.get("users/999")
    end
    assert_includes error.message, "404"
  end

  def test_error_handling_server_error
    stub_request(:get, "https://api.example.com/users")
      .to_return(status: 500, body: '{"error": "Internal server error"}', headers: { "Content-Type" => "application/json" })

    error = assert_raises(ServiceStack::Error) do
      @client.get("users")
    end
    assert_includes error.message, "500"
  end

  def test_empty_response_body
    stub_request(:post, "https://api.example.com/users")
      .to_return(status: 200, body: "", headers: { "Content-Type" => "application/json" })

    response = @client.post("users")
    assert_nil response
  end

  def test_invalid_json_response
    stub_request(:get, "https://api.example.com/invalid")
      .to_return(status: 200, body: "not json", headers: { "Content-Type" => "application/json" })

    error = assert_raises(ServiceStack::Error) do
      @client.get("invalid")
    end
    assert_includes error.message, "Invalid JSON response"
  end
end
