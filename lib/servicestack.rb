# frozen_string_literal: true

# Typed Ruby Client Library for consuming ServiceStack APIs.
#
# Generate typed DTOs for a remote ServiceStack API with get-dtos:
#
#   npx get-dtos ruby https://blazor-vue.web-templates.io
#
# Then send them with the client, which resolves each API's route, HTTP Method
# and Response Type from its Request DTO:
#
#   require 'servicestack'
#   require_relative 'dtos'
#
#   client = ServiceStack::JsonServiceClient.new('https://blazor-vue.web-templates.io')
#   res = client.send(Hello.new(name: 'World'))
#   puts res.result
require_relative 'servicestack/version'
require_relative 'servicestack/dto'
require_relative 'servicestack/types'
require_relative 'servicestack/web_service_exception'
require_relative 'servicestack/json_service_client'

module ServiceStack
  class Error < StandardError; end
end
