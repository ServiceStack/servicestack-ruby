# frozen_string_literal: true

module ServiceStack
  # Raised for failed API Requests, containing the HTTP Status Code and the
  # structured ResponseStatus error when the Server returned one.
  #
  #   begin
  #     client.send(CreateBooking.new)
  #   rescue ServiceStack::WebServiceException => e
  #     puts e.status_code           # 400
  #     puts e.error_code            # "NotEmpty"
  #     puts e.field_error('Name')   # "'Name' must not be empty."
  #   end
  class WebServiceException < StandardError
    attr_reader :status_code, :status_description, :response_status, :response_body, :inner_exception

    def initialize(message = nil, status_code: 0, status_description: nil, response_status: nil,
                   response_body: nil, inner_exception: nil)
      super(message || status_description || "HTTP Error #{status_code}")
      @status_code = status_code
      @status_description = status_description
      @response_status = response_status
      @response_body = response_body
      @inner_exception = inner_exception
    end

    # The ErrorCode of the error, e.g. "NotFound".
    def error_code = @response_status&.error_code

    # The error message.
    def error_message = @response_status&.message || message

    # Any field validation errors.
    def field_errors = @response_status&.errors || []

    # The validation error message for the field, if it has one.
    def field_error(field_name) = @response_status&.field_error(field_name)

    def unauthorized? = @status_code == 401
    def forbidden? = @status_code == 403
    def not_found? = @status_code == 404
    def validation_error? = !field_errors.empty?
  end
end
