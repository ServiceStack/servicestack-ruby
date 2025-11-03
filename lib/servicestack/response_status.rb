module ServiceStack
  # ResponseStatus DTO that matches ServiceStack's error response format
  class ResponseStatus
    attr_accessor :error_code, :message, :stack_trace, :errors, :meta

    def initialize(hash = {})
      @error_code = hash['errorCode'] || hash[:error_code]
      @message = hash['message'] || hash[:message]
      @stack_trace = hash['stackTrace'] || hash[:stack_trace]
      @errors = hash['errors'] || hash[:errors] || []
      @meta = hash['meta'] || hash[:meta] || {}
    end

    def to_hash
      {
        'errorCode' => @error_code,
        'message' => @message,
        'stackTrace' => @stack_trace,
        'errors' => @errors,
        'meta' => @meta
      }
    end
  end
end
