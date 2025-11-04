module ServiceStack
  # Exception thrown when a ServiceStack service returns an error
  class WebServiceException < StandardError
    attr_reader :status_code, :status_description, :response_status, :response_body

    def initialize(message, status_code: nil, status_description: nil, response_status: nil, response_body: nil)
      super(message)
      @status_code = status_code
      @status_description = status_description
      @response_status = response_status
      @response_body = response_body
    end

    def error_code
      @response_status&.error_code
    end

    def error_message
      @response_status&.message || message
    end
  end
end
