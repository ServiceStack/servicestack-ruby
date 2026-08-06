# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'servicestack'
require 'minitest/autorun'
require 'webmock/minitest'

# Typed DTOs generated from https://test.servicestack.net with:
#   npx get-dtos ruby https://test.servicestack.net
require_relative 'dtos'

module TestHelper
  BASE_URL = 'https://example.org'

  def error_body(error_code = 'NotEmpty', message = "'Name' must not be empty.", field_name = 'Name')
    {
      responseStatus: {
        errorCode: error_code,
        message: message,
        errors: [{ errorCode: error_code, fieldName: field_name, message: message }],
      },
    }.to_json
  end

  def client
    @client ||= ServiceStack::JsonServiceClient.new(BASE_URL)
  end
end
