# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'servicestack'
require 'minitest/autorun'
require 'webmock/minitest'

# Test DTOs matching the shape of generated DTOs.

class HelloResponse
  include ServiceStack::DTO
  attr_accessor :result, :response_status

  def self.properties
    {
      result: { name: 'result' },
      response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
    }
  end
end

class Hello
  include ServiceStack::DTO
  attr_accessor :name

  def self.properties = { name: { name: 'name' } }

  def response_type = HelloResponse
  def get_type_name = 'Hello'
  def get_method = 'GET'
end

class CreateHello
  include ServiceStack::DTO
  attr_accessor :name

  def self.properties = { name: { name: 'name' } }

  def response_type = HelloResponse
  def get_type_name = 'CreateHello'
  def get_method = 'POST'
end

class DeleteHello
  include ServiceStack::DTO
  attr_accessor :id

  def self.properties = { id: { name: 'id' } }

  def response_type = nil
  def get_type_name = 'DeleteHello'
  def get_method = 'DELETE'
end

class Coupon
  include ServiceStack::DTO
  attr_accessor :id, :description

  def self.properties
    {
      id: { name: 'id' },
      description: { name: 'description' },
    }
  end
end

class Booking < ServiceStack::AuditBase
  include ServiceStack::DTO
  attr_accessor :id, :name, :booking_start_date, :discount

  def self.properties
    {
      id: { name: 'id' },
      name: { name: 'name' },
      booking_start_date: { name: 'bookingStartDate', type: DateTime },
      discount: { name: 'discount', type: Coupon },
    }
  end
end

class QueryBookings < ServiceStack::QueryDb
  include ServiceStack::DTO
  attr_accessor :id

  def self.properties = { id: { name: 'id' } }

  def response_type = ServiceStack::QueryResponse.of(Booking)
  def get_type_name = 'QueryBookings'
  def get_method = 'GET'
end

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
