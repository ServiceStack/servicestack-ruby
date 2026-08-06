# frozen_string_literal: true

require_relative 'dto'

module ServiceStack
  # A field validation error within a ResponseStatus.
  class ResponseError
    include DTO
    attr_accessor :error_code, :field_name, :message, :meta

    def self.properties
      {
        error_code: { name: 'errorCode' },
        field_name: { name: 'fieldName' },
        message: { name: 'message' },
        meta: { name: 'meta' },
      }
    end
  end

  # ServiceStack's structured error, returned in the `responseStatus` property
  # of failed API Responses.
  class ResponseStatus
    include DTO
    attr_accessor :error_code, :message, :stack_trace, :errors, :meta

    def self.properties
      {
        error_code: { name: 'errorCode' },
        message: { name: 'message' },
        stack_trace: { name: 'stackTrace' },
        errors: { name: 'errors', type: [ResponseError] },
        meta: { name: 'meta' },
      }
    end

    # The validation error message for the field, matched case-insensitively.
    def field_error(field_name)
      error = get_field_error(field_name)
      error&.message
    end

    # The ResponseError for the field, matched case-insensitively.
    def get_field_error(field_name)
      (errors || []).find { |x| x.field_name.to_s.casecmp?(field_name.to_s) }
    end
  end

  # Returned by APIs with no Response Body.
  class EmptyResponse
    include DTO
    attr_accessor :response_status

    def self.properties
      { response_status: { name: 'responseStatus', type: ResponseStatus } }
    end
  end

  # Returned by APIs that return the Id of the created or updated entity.
  class IdResponse
    include DTO
    attr_accessor :id, :response_status

    def self.properties
      {
        id: { name: 'id' },
        response_status: { name: 'responseStatus', type: ResponseStatus },
      }
    end
  end

  # Returned by APIs that return a single string result.
  class StringResponse
    include DTO
    attr_accessor :result, :meta, :response_status

    def self.properties
      {
        result: { name: 'result' },
        meta: { name: 'meta' },
        response_status: { name: 'responseStatus', type: ResponseStatus },
      }
    end
  end

  # Returned by APIs that return a list of string results.
  class StringsResponse
    include DTO
    attr_accessor :results, :meta, :response_status

    def self.properties
      {
        results: { name: 'results' },
        meta: { name: 'meta' },
        response_status: { name: 'responseStatus', type: ResponseStatus },
      }
    end
  end

  # The audit fields of AutoQuery CRUD data models.
  class AuditBase
    include DTO
    attr_accessor :created_date, :created_by, :modified_date, :modified_by, :deleted_date, :deleted_by

    def self.properties
      {
        created_date: { name: 'createdDate', type: DateTime },
        created_by: { name: 'createdBy' },
        modified_date: { name: 'modifiedDate', type: DateTime },
        modified_by: { name: 'modifiedBy' },
        deleted_date: { name: 'deletedDate', type: DateTime },
        deleted_by: { name: 'deletedBy' },
      }
    end
  end

  # The query params supported by all AutoQuery Requests.
  class QueryBase
    include DTO
    attr_accessor :skip, :take, :order_by, :order_by_desc, :include, :fields, :meta

    def self.properties
      {
        skip: { name: 'skip' },
        take: { name: 'take' },
        order_by: { name: 'orderBy' },
        order_by_desc: { name: 'orderByDesc' },
        include: { name: 'include' },
        fields: { name: 'fields' },
        meta: { name: 'meta' },
      }
    end
  end

  # The base of AutoQuery RDBMS Requests.
  class QueryDb < QueryBase; end

  # The base of AutoQuery Data Requests.
  class QueryData < QueryBase; end

  # The typed Response of AutoQuery Requests.
  #
  # Use `QueryResponse.of(Booking)` for a Response that converts its `results`
  # into the specified Type, which is what generated AutoQuery DTOs return.
  class QueryResponse
    include DTO
    attr_accessor :offset, :total, :results, :meta, :response_status

    class << self
      attr_accessor :results_type

      # A QueryResponse that converts its results into the specified Type.
      def of(type)
        @of_types ||= {}
        @of_types[type] ||= Class.new(self) do
          self.results_type = type
        end
      end

      def properties
        {
          offset: { name: 'offset' },
          total: { name: 'total' },
          results: { name: 'results', type: [results_type].compact },
          meta: { name: 'meta' },
          response_status: { name: 'responseStatus', type: ResponseStatus },
        }
      end
    end
  end

  # Authenticate with a ServiceStack Service.
  class Authenticate
    include DTO
    attr_accessor :provider, :user_name, :password, :remember_me, :access_token,
                  :access_token_secret, :return_url, :error_view, :meta

    def self.properties
      {
        provider: { name: 'provider' },
        user_name: { name: 'userName' },
        password: { name: 'password' },
        remember_me: { name: 'rememberMe' },
        access_token: { name: 'accessToken' },
        access_token_secret: { name: 'accessTokenSecret' },
        return_url: { name: 'returnUrl' },
        error_view: { name: 'errorView' },
        meta: { name: 'meta' },
      }
    end

    def response_type = AuthenticateResponse
    def get_type_name = 'Authenticate'
    def get_method = 'POST'
  end

  # The Response of a successful Authenticate Request.
  class AuthenticateResponse
    include DTO
    attr_accessor :user_id, :session_id, :user_name, :display_name, :referrer_url,
                  :bearer_token, :refresh_token, :refresh_token_expiry, :profile_url,
                  :roles, :permissions, :auth_provider, :response_status, :meta

    def self.properties
      {
        user_id: { name: 'userId' },
        session_id: { name: 'sessionId' },
        user_name: { name: 'userName' },
        display_name: { name: 'displayName' },
        referrer_url: { name: 'referrerUrl' },
        bearer_token: { name: 'bearerToken' },
        refresh_token: { name: 'refreshToken' },
        refresh_token_expiry: { name: 'refreshTokenExpiry', type: DateTime },
        profile_url: { name: 'profileUrl' },
        roles: { name: 'roles' },
        permissions: { name: 'permissions' },
        auth_provider: { name: 'authProvider' },
        response_status: { name: 'responseStatus', type: ResponseStatus },
        meta: { name: 'meta' },
      }
    end
  end

  # Register a new User.
  class Register
    include DTO
    attr_accessor :user_name, :first_name, :last_name, :display_name, :email,
                  :password, :confirm_password, :auto_login, :error_view, :meta

    def self.properties
      {
        user_name: { name: 'userName' },
        first_name: { name: 'firstName' },
        last_name: { name: 'lastName' },
        display_name: { name: 'displayName' },
        email: { name: 'email' },
        password: { name: 'password' },
        confirm_password: { name: 'confirmPassword' },
        auto_login: { name: 'autoLogin' },
        error_view: { name: 'errorView' },
        meta: { name: 'meta' },
      }
    end

    def response_type = RegisterResponse
    def get_type_name = 'Register'
    def get_method = 'POST'
  end

  # The Response of a successful Register Request.
  class RegisterResponse
    include DTO
    attr_accessor :user_id, :session_id, :user_name, :referrer_url, :bearer_token,
                  :refresh_token, :refresh_token_expiry, :roles, :permissions,
                  :redirect_url, :response_status, :meta

    def self.properties
      {
        user_id: { name: 'userId' },
        session_id: { name: 'sessionId' },
        user_name: { name: 'userName' },
        referrer_url: { name: 'referrerUrl' },
        bearer_token: { name: 'bearerToken' },
        refresh_token: { name: 'refreshToken' },
        refresh_token_expiry: { name: 'refreshTokenExpiry', type: DateTime },
        roles: { name: 'roles' },
        permissions: { name: 'permissions' },
        redirect_url: { name: 'redirectUrl' },
        response_status: { name: 'responseStatus', type: ResponseStatus },
        meta: { name: 'meta' },
      }
    end
  end

  # Exchange a Refresh Token for a new JWT Bearer Token.
  class GetAccessToken
    include DTO
    attr_accessor :refresh_token, :meta

    def self.properties
      {
        refresh_token: { name: 'refreshToken' },
        meta: { name: 'meta' },
      }
    end

    def response_type = GetAccessTokenResponse
    def get_type_name = 'GetAccessToken'
    def get_method = 'POST'
  end

  # The Response of GetAccessToken.
  class GetAccessTokenResponse
    include DTO
    attr_accessor :access_token, :response_status, :meta

    def self.properties
      {
        access_token: { name: 'accessToken' },
        response_status: { name: 'responseStatus', type: ResponseStatus },
        meta: { name: 'meta' },
      }
    end
  end

  # Convert an authenticated Session into a JWT Bearer Token.
  class ConvertSessionToToken
    include DTO
    attr_accessor :preserve_session, :meta

    def self.properties
      {
        preserve_session: { name: 'preserveSession' },
        meta: { name: 'meta' },
      }
    end

    def response_type = ConvertSessionToTokenResponse
    def get_type_name = 'ConvertSessionToToken'
    def get_method = 'POST'
  end

  # The Response of ConvertSessionToToken.
  class ConvertSessionToTokenResponse
    include DTO
    attr_accessor :access_token, :refresh_token, :response_status, :meta

    def self.properties
      {
        access_token: { name: 'accessToken' },
        refresh_token: { name: 'refreshToken' },
        response_status: { name: 'responseStatus', type: ResponseStatus },
        meta: { name: 'meta' },
      }
    end
  end
end
