# frozen_string_literal: true
# encoding: utf-8

# Options:
=begin
Date: 2026-08-06 15:16:30
Version: 10.09
Tip: To override a DTO option, remove "//" prefix before updating
BaseUrl: https://test.servicestack.net

#MakePartial: True
#MakeVirtual: True
#MakeInternal: False
#MakeDataContractsExtensible: False
#AddReturnMarker: True
#AddDescriptionAsComments: True
#AddDataContractAttributes: False
#AddIndexesToDataMembers: False
#AddGeneratedCodeAttributes: False
#AddResponseStatus: False
#AddImplicitVersion: 
#InitializeCollections: False
#ExportValueTypes: False
#IncludeTypes: 
#ExcludeTypes: 
#AddNamespaces: 
#AddDefaultXmlNamespace: http://schemas.servicestack.net/types
=end

require 'json'
require 'servicestack'


module EnumType
    VALUE1 = 'Value1'
    VALUE2 = 'Value2'
    VALUE3 = 'Value3'
end

# @Flags
module EnumTypeFlags
    VALUE1 = 0
    VALUE2 = 1
    VALUE3 = 2
end

module EnumWithValues
    NONE = 'None'
    VALUE1 = 'Value1'
    VALUE2 = 'Value2'
end

# @Flags
module EnumFlags
    VALUE0 = 0
    VALUE1 = 1
    VALUE2 = 2
    VALUE3 = 4
    VALUE123 = 7
end

module EnumAsInt
    VALUE1 = 'Value1'
    VALUE2 = 'Value2'
    VALUE3 = 'Value3'
end

module EnumStyle
    LOWER = 'lower'
    UPPER = 'UPPER'
    PASCAL_CASE = 'PascalCase'
    CAMEL_CASE = 'camelCase'
    CAMEL_U_P_P_E_R = 'camelUPPER'
    PASCAL_U_P_P_E_R = 'PascalUPPER'
end

module EnumStyleMembers
    LOWER = 'Lower'
    UPPER = 'Upper'
    PASCAL_CASE = 'PascalCase'
    CAMEL_CASE = 'CamelCase'
    CAMEL_UPPER = 'CamelUpper'
    PASCAL_UPPER = 'PascalUpper'
end

module DayOfWeek
    SUNDAY = 'Sunday'
    MONDAY = 'Monday'
    TUESDAY = 'Tuesday'
    WEDNESDAY = 'Wednesday'
    THURSDAY = 'Thursday'
    FRIDAY = 'Friday'
    SATURDAY = 'Saturday'
end

# @DataContract
module ScopeType
    GLOBAL = 'Global'
    SALE = 'Sale'
end

module ResponseFormat
    TEXT = 'Text'
    JSON_OBJECT = 'JsonObject'
end

module ToolType
    FUNCTION = 'Function'
end

module RoomType
    SINGLE = 'Single'
    DOUBLE = 'Double'
    QUEEN = 'Queen'
    TWIN = 'Twin'
    SUITE = 'Suite'
end

module LivingStatus
    ALIVE = 'Alive'
    DEAD = 'Dead'
end

module InnerEnum
    FOO = 'Foo'
    BAR = 'Bar'
    BAZ = 'Baz'
end

module IReturn
    def response_type() = T
    def get_type_name() = 'IReturn'
end

module IReturnVoid
    def response_type() = nil
    def get_type_name() = 'IReturnVoid'
end

module IPost
end

module IGet
end

module ICreateDb
end

module IUpdateDb
end

module IPatchDb
end

module ISaveDb
end

module IHasSessionId
    # @return [String]
    attr_accessor :session_id
end

module IHasBearerToken
    # @return [String]
    attr_accessor :bearer_token
end

module IPut
end

module IDelete
end

module IPatch
end

module IDeleteDb
end

class Item
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :description

    def self.properties
        {
            name: { name: 'name' },
            description: { name: 'description' },
        }
    end

end

class Poco
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

end

class CustomType
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

end

class SetterType
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

end

class DeclarativeChildValidation
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @Validate(Validator: "MaximumLength(20)")
    # @return [String]
    attr_accessor :value

    def self.properties
        {
            name: { name: 'name' },
            value: { name: 'value' },
        }
    end

end

class FluentChildValidation
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :value

    def self.properties
        {
            name: { name: 'name' },
            value: { name: 'value' },
        }
    end

end

class DeclarativeSingleValidation
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @Validate(Validator: "MaximumLength(20)")
    # @return [String]
    attr_accessor :value

    def self.properties
        {
            name: { name: 'name' },
            value: { name: 'value' },
        }
    end

end

class FluentSingleValidation
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :value

    def self.properties
        {
            name: { name: 'name' },
            value: { name: 'value' },
        }
    end

end

# @DataContract
class CancelRequest
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :tag

    # @DataMember(Order=2)
    # @return [Dictionary]
    attr_accessor :meta

    def self.properties
        {
            tag: { name: 'tag' },
            meta: { name: 'meta' },
        }
    end

    def response_type() = CancelRequestResponse
    def get_type_name() = 'CancelRequest'
end

# @DataContract
class CancelRequestResponse
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :tag

    # @DataMember(Order=2)
    # @return [Time]
    attr_accessor :elapsed

    # @DataMember(Order=3)
    # @return [Dictionary]
    attr_accessor :meta

    # @DataMember(Order=4)
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            tag: { name: 'tag' },
            elapsed: { name: 'elapsed' },
            meta: { name: 'meta' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

# @DataContract
class UpdateEventSubscriber
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :id

    # @DataMember(Order=2)
    # @return [Array]
    attr_accessor :subscribe_channels

    # @DataMember(Order=3)
    # @return [Array]
    attr_accessor :unsubscribe_channels

    def self.properties
        {
            id: { name: 'id' },
            subscribe_channels: { name: 'subscribeChannels' },
            unsubscribe_channels: { name: 'unsubscribeChannels' },
        }
    end

    def response_type() = UpdateEventSubscriberResponse
    def get_type_name() = 'UpdateEventSubscriber'
end

# @DataContract
class UpdateEventSubscriberResponse
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

# @DataContract
class GetApiKeys
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :environment

    # @DataMember(Order=2)
    # @return [Dictionary]
    attr_accessor :meta

    def self.properties
        {
            environment: { name: 'environment' },
            meta: { name: 'meta' },
        }
    end

    def response_type() = GetApiKeysResponse
    def get_type_name() = 'GetApiKeys'
end

# @DataContract
class UserApiKey
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :key

    # @DataMember(Order=2)
    # @return [String]
    attr_accessor :key_type

    # @DataMember(Order=3)
    # @return [DateTime]
    attr_accessor :expiry_date

    # @DataMember(Order=4)
    # @return [Dictionary]
    attr_accessor :meta

    def self.properties
        {
            key: { name: 'key' },
            key_type: { name: 'keyType' },
            expiry_date: { name: 'expiryDate', type: DateTime },
            meta: { name: 'meta' },
        }
    end

end

# @DataContract
class GetApiKeysResponse
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [List]
    attr_accessor :results

    # @DataMember(Order=2)
    # @return [Dictionary]
    attr_accessor :meta

    # @DataMember(Order=3)
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            results: { name: 'results', type: [UserApiKey] },
            meta: { name: 'meta' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

# @DataContract
class RegenerateApiKeys
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :environment

    # @DataMember(Order=2)
    # @return [Dictionary]
    attr_accessor :meta

    def self.properties
        {
            environment: { name: 'environment' },
            meta: { name: 'meta' },
        }
    end

    def response_type() = RegenerateApiKeysResponse
    def get_type_name() = 'RegenerateApiKeys'
end

# @DataContract
class RegenerateApiKeysResponse
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [List]
    attr_accessor :results

    # @DataMember(Order=2)
    # @return [Dictionary]
    attr_accessor :meta

    # @DataMember(Order=3)
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            results: { name: 'results', type: [UserApiKey] },
            meta: { name: 'meta' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class NavItem
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :label
    # @return [String]
    attr_accessor :href
    # @return [TrueClass]
    attr_accessor :exact
    # @return [String]
    attr_accessor :id
    # @return [String]
    attr_accessor :class_name
    # @return [String]
    attr_accessor :icon_class
    # @return [String]
    attr_accessor :icon_src
    # @return [String]
    attr_accessor :show
    # @return [String]
    attr_accessor :hide
    # @return [List]
    attr_accessor :children
    # @return [Dictionary]
    attr_accessor :meta

    def self.properties
        {
            label: { name: 'label' },
            href: { name: 'href' },
            exact: { name: 'exact' },
            id: { name: 'id' },
            class_name: { name: 'className' },
            icon_class: { name: 'iconClass' },
            icon_src: { name: 'iconSrc' },
            show: { name: 'show' },
            hide: { name: 'hide' },
            children: { name: 'children', type: [NavItem] },
            meta: { name: 'meta' },
        }
    end

end

# @DataContract
class GetNavItems
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = GetNavItemsResponse
    def get_type_name() = 'GetNavItems'
end

# @DataContract
class GetNavItemsResponse
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :base_url

    # @DataMember(Order=2)
    # @return [List]
    attr_accessor :results

    # @DataMember(Order=3)
    # @return [Dictionary]
    attr_accessor :nav_items_map

    # @DataMember(Order=4)
    # @return [Dictionary]
    attr_accessor :meta

    # @DataMember(Order=5)
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            base_url: { name: 'baseUrl' },
            results: { name: 'results', type: [NavItem] },
            nav_items_map: { name: 'navItemsMap' },
            meta: { name: 'meta' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

module IGeneration
    # @return [String]
    attr_accessor :ref_id
    # @return [String]
    attr_accessor :tag
end

module IAuthTokens
    # @return [String]
    attr_accessor :provider
    # @return [String]
    attr_accessor :user_id
    # @return [String]
    attr_accessor :access_token
    # @return [String]
    attr_accessor :access_token_secret
    # @return [String]
    attr_accessor :refresh_token
    # @return [DateTime]
    attr_accessor :refresh_token_expiry
    # @return [String]
    attr_accessor :request_token
    # @return [String]
    attr_accessor :request_token_secret
    # @return [Dictionary]
    attr_accessor :items
end

# @DataContract
class AuthUserSession
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :referrer_url

    # @DataMember(Order=2)
    # @return [String]
    attr_accessor :id

    # @DataMember(Order=3)
    # @return [String]
    attr_accessor :user_auth_id

    # @DataMember(Order=4)
    # @return [String]
    attr_accessor :user_auth_name

    # @DataMember(Order=5)
    # @return [String]
    attr_accessor :user_name

    # @DataMember(Order=6)
    # @return [String]
    attr_accessor :twitter_user_id

    # @DataMember(Order=7)
    # @return [String]
    attr_accessor :twitter_screen_name

    # @DataMember(Order=8)
    # @return [String]
    attr_accessor :facebook_user_id

    # @DataMember(Order=9)
    # @return [String]
    attr_accessor :facebook_user_name

    # @DataMember(Order=10)
    # @return [String]
    attr_accessor :first_name

    # @DataMember(Order=11)
    # @return [String]
    attr_accessor :last_name

    # @DataMember(Order=12)
    # @return [String]
    attr_accessor :display_name

    # @DataMember(Order=13)
    # @return [String]
    attr_accessor :company

    # @DataMember(Order=14)
    # @return [String]
    attr_accessor :email

    # @DataMember(Order=15)
    # @return [String]
    attr_accessor :primary_email

    # @DataMember(Order=16)
    # @return [String]
    attr_accessor :phone_number

    # @DataMember(Order=17)
    # @return [DateTime]
    attr_accessor :birth_date

    # @DataMember(Order=18)
    # @return [String]
    attr_accessor :birth_date_raw

    # @DataMember(Order=19)
    # @return [String]
    attr_accessor :address

    # @DataMember(Order=20)
    # @return [String]
    attr_accessor :address2

    # @DataMember(Order=21)
    # @return [String]
    attr_accessor :city

    # @DataMember(Order=22)
    # @return [String]
    attr_accessor :state

    # @DataMember(Order=23)
    # @return [String]
    attr_accessor :country

    # @DataMember(Order=24)
    # @return [String]
    attr_accessor :culture

    # @DataMember(Order=25)
    # @return [String]
    attr_accessor :full_name

    # @DataMember(Order=26)
    # @return [String]
    attr_accessor :gender

    # @DataMember(Order=27)
    # @return [String]
    attr_accessor :language

    # @DataMember(Order=28)
    # @return [String]
    attr_accessor :mail_address

    # @DataMember(Order=29)
    # @return [String]
    attr_accessor :nickname

    # @DataMember(Order=30)
    # @return [String]
    attr_accessor :postal_code

    # @DataMember(Order=31)
    # @return [String]
    attr_accessor :time_zone

    # @DataMember(Order=32)
    # @return [String]
    attr_accessor :request_token_secret

    # @DataMember(Order=33)
    # @return [DateTime]
    attr_accessor :created_at

    # @DataMember(Order=34)
    # @return [DateTime]
    attr_accessor :last_modified

    # @DataMember(Order=35)
    # @return [List]
    attr_accessor :roles

    # @DataMember(Order=36)
    # @return [List]
    attr_accessor :permissions

    # @DataMember(Order=37)
    # @return [TrueClass]
    attr_accessor :is_authenticated

    # @DataMember(Order=38)
    # @return [TrueClass]
    attr_accessor :from_token

    # @DataMember(Order=39)
    # @return [String]
    attr_accessor :profile_url

    # @DataMember(Order=40)
    # @return [String]
    attr_accessor :sequence

    # @DataMember(Order=41)
    # @return [Integer]
    attr_accessor :tag

    # @DataMember(Order=42)
    # @return [String]
    attr_accessor :auth_provider

    # @DataMember(Order=43)
    # @return [List]
    attr_accessor :provider_o_auth_access

    # @DataMember(Order=44)
    # @return [Dictionary]
    attr_accessor :meta

    # @DataMember(Order=45)
    # @return [List]
    attr_accessor :audiences

    # @DataMember(Order=46)
    # @return [List]
    attr_accessor :scopes

    # @DataMember(Order=47)
    # @return [String]
    attr_accessor :dns

    # @DataMember(Order=48)
    # @return [String]
    attr_accessor :rsa

    # @DataMember(Order=49)
    # @return [String]
    attr_accessor :sid

    # @DataMember(Order=50)
    # @return [String]
    attr_accessor :hash

    # @DataMember(Order=51)
    # @return [String]
    attr_accessor :home_phone

    # @DataMember(Order=52)
    # @return [String]
    attr_accessor :mobile_phone

    # @DataMember(Order=53)
    # @return [String]
    attr_accessor :webpage

    # @DataMember(Order=54)
    # @return [TrueClass]
    attr_accessor :email_confirmed

    # @DataMember(Order=55)
    # @return [TrueClass]
    attr_accessor :phone_number_confirmed

    # @DataMember(Order=56)
    # @return [TrueClass]
    attr_accessor :two_factor_enabled

    # @DataMember(Order=57)
    # @return [String]
    attr_accessor :security_stamp

    # @DataMember(Order=58)
    # @return [String]
    attr_accessor :type

    # @DataMember(Order=59)
    # @return [String]
    attr_accessor :recovery_token

    # @DataMember(Order=60)
    # @return [Integer]
    attr_accessor :ref_id

    # @DataMember(Order=61)
    # @return [String]
    attr_accessor :ref_id_str

    def self.properties
        {
            referrer_url: { name: 'referrerUrl' },
            id: { name: 'id' },
            user_auth_id: { name: 'userAuthId' },
            user_auth_name: { name: 'userAuthName' },
            user_name: { name: 'userName' },
            twitter_user_id: { name: 'twitterUserId' },
            twitter_screen_name: { name: 'twitterScreenName' },
            facebook_user_id: { name: 'facebookUserId' },
            facebook_user_name: { name: 'facebookUserName' },
            first_name: { name: 'firstName' },
            last_name: { name: 'lastName' },
            display_name: { name: 'displayName' },
            company: { name: 'company' },
            email: { name: 'email' },
            primary_email: { name: 'primaryEmail' },
            phone_number: { name: 'phoneNumber' },
            birth_date: { name: 'birthDate', type: DateTime },
            birth_date_raw: { name: 'birthDateRaw' },
            address: { name: 'address' },
            address2: { name: 'address2' },
            city: { name: 'city' },
            state: { name: 'state' },
            country: { name: 'country' },
            culture: { name: 'culture' },
            full_name: { name: 'fullName' },
            gender: { name: 'gender' },
            language: { name: 'language' },
            mail_address: { name: 'mailAddress' },
            nickname: { name: 'nickname' },
            postal_code: { name: 'postalCode' },
            time_zone: { name: 'timeZone' },
            request_token_secret: { name: 'requestTokenSecret' },
            created_at: { name: 'createdAt', type: DateTime },
            last_modified: { name: 'lastModified', type: DateTime },
            roles: { name: 'roles' },
            permissions: { name: 'permissions' },
            is_authenticated: { name: 'isAuthenticated' },
            from_token: { name: 'fromToken' },
            profile_url: { name: 'profileUrl' },
            sequence: { name: 'sequence' },
            tag: { name: 'tag' },
            auth_provider: { name: 'authProvider' },
            provider_o_auth_access: { name: 'providerOAuthAccess', type: [IAuthTokens] },
            meta: { name: 'meta' },
            audiences: { name: 'audiences' },
            scopes: { name: 'scopes' },
            dns: { name: 'dns' },
            rsa: { name: 'rsa' },
            sid: { name: 'sid' },
            hash: { name: 'hash' },
            home_phone: { name: 'homePhone' },
            mobile_phone: { name: 'mobilePhone' },
            webpage: { name: 'webpage' },
            email_confirmed: { name: 'emailConfirmed' },
            phone_number_confirmed: { name: 'phoneNumberConfirmed' },
            two_factor_enabled: { name: 'twoFactorEnabled' },
            security_stamp: { name: 'securityStamp' },
            type: { name: 'type' },
            recovery_token: { name: 'recoveryToken' },
            ref_id: { name: 'refId' },
            ref_id_str: { name: 'refIdStr' },
        }
    end

end

class NestedClass
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :value

    def self.properties
        {
            value: { name: 'value' },
        }
    end

end

class KeyValuePair
    include ServiceStack::DTO

    # @return [TKey]
    attr_accessor :key
    # @return [TValue]
    attr_accessor :value

    def self.properties
        {
            key: { name: 'key' },
            value: { name: 'value' },
        }
    end

end

class SubType
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

end

class AllTypesBase
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [Integer]
    attr_accessor :nullable_id
    # @return [Integer]
    attr_accessor :byte
    # @return [Integer]
    attr_accessor :short
    # @return [Integer]
    attr_accessor :int
    # @return [Integer]
    attr_accessor :long
    # @return [Integer]
    attr_accessor :u_short
    # @return [Integer]
    attr_accessor :u_int
    # @return [Integer]
    attr_accessor :u_long
    # @return [Float]
    attr_accessor :float
    # @return [Float]
    attr_accessor :double
    # @return [BigDecimal]
    attr_accessor :decimal
    # @return [String]
    attr_accessor :string
    # @return [DateTime]
    attr_accessor :date_time
    # @return [Time]
    attr_accessor :time_span
    # @return [DateTime]
    attr_accessor :date_time_offset
    # @return [String]
    attr_accessor :guid
    # @return [String]
    attr_accessor :char
    # @return [KeyValuePair]
    attr_accessor :key_value_pair
    # @return [DateTime]
    attr_accessor :nullable_date_time
    # @return [Time]
    attr_accessor :nullable_time_span
    # @return [List]
    attr_accessor :string_list
    # @return [Array]
    attr_accessor :string_array
    # @return [Dictionary]
    attr_accessor :string_map
    # @return [Dictionary]
    attr_accessor :int_string_map
    # @return [SubType]
    attr_accessor :sub_type

    def self.properties
        {
            id: { name: 'id' },
            nullable_id: { name: 'nullableId' },
            byte: { name: 'byte' },
            short: { name: 'short' },
            int: { name: 'int' },
            long: { name: 'long' },
            u_short: { name: 'uShort' },
            u_int: { name: 'uInt' },
            u_long: { name: 'uLong' },
            float: { name: 'float' },
            double: { name: 'double' },
            decimal: { name: 'decimal' },
            string: { name: 'string' },
            date_time: { name: 'dateTime', type: DateTime },
            time_span: { name: 'timeSpan' },
            date_time_offset: { name: 'dateTimeOffset', type: DateTime },
            guid: { name: 'guid' },
            char: { name: 'char' },
            key_value_pair: { name: 'keyValuePair', type: KeyValuePair },
            nullable_date_time: { name: 'nullableDateTime', type: DateTime },
            nullable_time_span: { name: 'nullableTimeSpan' },
            string_list: { name: 'stringList' },
            string_array: { name: 'stringArray' },
            string_map: { name: 'stringMap' },
            int_string_map: { name: 'intStringMap' },
            sub_type: { name: 'subType', type: SubType },
        }
    end

end

class HelloBase
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

end

class HelloBase_1
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :items
    # @return [List]
    attr_accessor :counts

    def self.properties
        {
            items: { name: 'items' },
            counts: { name: 'counts' },
        }
    end

end

module IPoco
    # @return [String]
    attr_accessor :name
end

module IEmptyInterface
end

class EmptyClass
    include ServiceStack::DTO

end

class Channel
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :value

    def self.properties
        {
            name: { name: 'name' },
            value: { name: 'value' },
        }
    end

end

class Device
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :type
    # @return [Integer]
    attr_accessor :time_stamp
    # @return [List]
    attr_accessor :channels

    def self.properties
        {
            id: { name: 'id' },
            type: { name: 'type' },
            time_stamp: { name: 'timeStamp' },
            channels: { name: 'channels', type: [Channel] },
        }
    end

end

class Logger
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [List]
    attr_accessor :devices

    def self.properties
        {
            id: { name: 'id' },
            devices: { name: 'devices', type: [Device] },
        }
    end

end

class Rockstar
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :first_name
    # @return [String]
    attr_accessor :last_name
    # @return [Integer]
    attr_accessor :age

    def self.properties
        {
            id: { name: 'id' },
            first_name: { name: 'firstName' },
            last_name: { name: 'lastName' },
            age: { name: 'age' },
        }
    end

end

# @DataContract
class AiContent
    include ServiceStack::DTO

    # @DataMember(Name="type")
    # @return [String]
    attr_accessor :type

    def self.properties
        {
            type: { name: 'type' },
        }
    end

end

#
# The function that the model called.
#
# @DataContract
class ToolFunction
    include ServiceStack::DTO

    # @DataMember(Name="name")
    # @return [String]
    attr_accessor :name

    # @DataMember(Name="arguments")
    # @return [String]
    attr_accessor :arguments

    def self.properties
        {
            name: { name: 'name' },
            arguments: { name: 'arguments' },
        }
    end

end

#
# The tool calls generated by the model, such as function calls.
#
# @DataContract
class ToolCall
    include ServiceStack::DTO

    # @DataMember(Name="id")
    # @return [String]
    attr_accessor :id

    # @DataMember(Name="type")
    # @return [String]
    attr_accessor :type

    # @DataMember(Name="function")
    # @return [ToolFunction]
    attr_accessor :function

    def self.properties
        {
            id: { name: 'id' },
            type: { name: 'type' },
            function: { name: 'function', type: ToolFunction },
        }
    end

end

#
# A list of messages comprising the conversation so far.
#
# @DataContract
class AiMessage
    include ServiceStack::DTO

    # @DataMember(Name="content")
    # @return [List]
    attr_accessor :content

    # @DataMember(Name="role")
    # @return [String]
    attr_accessor :role

    # @DataMember(Name="name")
    # @return [String]
    attr_accessor :name

    # @DataMember(Name="tool_calls")
    # @return [List]
    attr_accessor :tool_calls

    # @DataMember(Name="tool_call_id")
    # @return [String]
    attr_accessor :tool_call_id

    # @DataMember(Name="reasoning")
    # @return [String]
    attr_accessor :reasoning

    # @DataMember(Name="reasoning_content")
    # @return [String]
    attr_accessor :reasoning_content

    # @DataMember(Name="timestamp")
    # @return [Integer]
    attr_accessor :timestamp

    # @DataMember(Name="images")
    # @return [List]
    attr_accessor :images

    def self.properties
        {
            content: { name: 'content', type: [AiContent] },
            role: { name: 'role' },
            name: { name: 'name' },
            tool_calls: { name: 'tool_calls', type: [ToolCall] },
            tool_call_id: { name: 'tool_call_id' },
            reasoning: { name: 'reasoning' },
            reasoning_content: { name: 'reasoning_content' },
            timestamp: { name: 'timestamp' },
            images: { name: 'images', type: [AiContent] },
        }
    end

end

#
# Parameters for audio output. Required when audio output is requested with modalities: [audio]
#
# @DataContract
class AiChatAudio
    include ServiceStack::DTO

    # @DataMember(Name="format")
    # @return [String]
    attr_accessor :format

    # @DataMember(Name="voice")
    # @return [String]
    attr_accessor :voice

    def self.properties
        {
            format: { name: 'format' },
            voice: { name: 'voice' },
        }
    end

end

# @DataContract
class AiResponseFormat
    include ServiceStack::DTO

    # @DataMember(Name="type")
    # @return [ResponseFormat]
    attr_accessor :type

    def self.properties
        {
            type: { name: 'type' },
        }
    end

end

# @DataContract
class AiToolFunction
    include ServiceStack::DTO

    # @DataMember(Name="name")
    # @return [String]
    attr_accessor :name

    # @DataMember(Name="description")
    # @return [String]
    attr_accessor :description

    # @DataMember(Name="parameters")
    # @return [Dictionary]
    attr_accessor :parameters

    def self.properties
        {
            name: { name: 'name' },
            description: { name: 'description' },
            parameters: { name: 'parameters' },
        }
    end

end

# @DataContract
class Tool
    include ServiceStack::DTO

    # @DataMember(Name="type")
    # @return [ToolType]
    attr_accessor :type

    # @DataMember(Name="function")
    # @return [AiToolFunction]
    attr_accessor :function

    def self.properties
        {
            type: { name: 'type' },
            function: { name: 'function', type: AiToolFunction },
        }
    end

end

#
# Discount Coupons
#
class Coupon
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :id
    # @return [String]
    attr_accessor :description
    # @return [Integer]
    attr_accessor :discount
    # @return [DateTime]
    attr_accessor :expiry_date

    def self.properties
        {
            id: { name: 'id' },
            description: { name: 'description' },
            discount: { name: 'discount' },
            expiry_date: { name: 'expiryDate', type: DateTime },
        }
    end

end

class Address
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :address_text

    def self.properties
        {
            id: { name: 'id' },
            address_text: { name: 'addressText' },
        }
    end

end

#
# Booking Details
#
class Booking < ServiceStack::AuditBase
    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name
    # @return [RoomType]
    attr_accessor :room_type
    # @return [Integer]
    attr_accessor :room_number
    # @return [DateTime]
    attr_accessor :booking_start_date
    # @return [DateTime]
    attr_accessor :booking_end_date
    # @return [BigDecimal]
    attr_accessor :cost
    # @References('Coupon')
    # @return [String]
    attr_accessor :coupon_id

    # @return [Coupon]
    attr_accessor :discount
    # @return [String]
    attr_accessor :notes
    # @return [TrueClass]
    attr_accessor :cancelled
    # @References('Address')
    # @return [Integer]
    attr_accessor :permanent_address_id

    # @return [Address]
    attr_accessor :permanent_address
    # @References('Address')
    # @return [Integer]
    attr_accessor :postal_address_id

    # @return [Address]
    attr_accessor :postal_address

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
            room_type: { name: 'roomType' },
            room_number: { name: 'roomNumber' },
            booking_start_date: { name: 'bookingStartDate', type: DateTime },
            booking_end_date: { name: 'bookingEndDate', type: DateTime },
            cost: { name: 'cost' },
            coupon_id: { name: 'couponId' },
            discount: { name: 'discount', type: Coupon },
            notes: { name: 'notes' },
            cancelled: { name: 'cancelled' },
            permanent_address_id: { name: 'permanentAddressId' },
            permanent_address: { name: 'permanentAddress', type: Address },
            postal_address_id: { name: 'postalAddressId' },
            postal_address: { name: 'postalAddress', type: Address },
        }
    end

end

class QueryDbTenant < ServiceStack::QueryDb
end

class RockstarAuditTenant < ServiceStack::AuditBase
    # @return [Integer]
    attr_accessor :tenant_id
    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :first_name
    # @return [String]
    attr_accessor :last_name
    # @return [Integer]
    attr_accessor :age
    # @return [DateTime]
    attr_accessor :date_of_birth
    # @return [DateTime]
    attr_accessor :date_died
    # @return [LivingStatus]
    attr_accessor :living_status

    def self.properties
        {
            tenant_id: { name: 'tenantId' },
            id: { name: 'id' },
            first_name: { name: 'firstName' },
            last_name: { name: 'lastName' },
            age: { name: 'age' },
            date_of_birth: { name: 'dateOfBirth', type: DateTime },
            date_died: { name: 'dateDied', type: DateTime },
            living_status: { name: 'livingStatus' },
        }
    end

end

class RockstarBase
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :first_name
    # @return [String]
    attr_accessor :last_name
    # @return [Integer]
    attr_accessor :age
    # @return [DateTime]
    attr_accessor :date_of_birth
    # @return [DateTime]
    attr_accessor :date_died
    # @return [LivingStatus]
    attr_accessor :living_status

    def self.properties
        {
            first_name: { name: 'firstName' },
            last_name: { name: 'lastName' },
            age: { name: 'age' },
            date_of_birth: { name: 'dateOfBirth', type: DateTime },
            date_died: { name: 'dateDied', type: DateTime },
            living_status: { name: 'livingStatus' },
        }
    end

end

class RockstarAuto < RockstarBase
    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

end

class OnlyDefinedInGenericType
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

end

class OnlyDefinedInGenericTypeFrom
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

end

class OnlyDefinedInGenericTypeInto
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

end

class RockstarAudit < RockstarBase
    # @return [Integer]
    attr_accessor :id
    # @return [DateTime]
    attr_accessor :created_date
    # @return [String]
    attr_accessor :created_by
    # @return [String]
    attr_accessor :created_info
    # @return [DateTime]
    attr_accessor :modified_date
    # @return [String]
    attr_accessor :modified_by
    # @return [String]
    attr_accessor :modified_info

    def self.properties
        {
            id: { name: 'id' },
            created_date: { name: 'createdDate', type: DateTime },
            created_by: { name: 'createdBy' },
            created_info: { name: 'createdInfo' },
            modified_date: { name: 'modifiedDate', type: DateTime },
            modified_by: { name: 'modifiedBy' },
            modified_info: { name: 'modifiedInfo' },
        }
    end

end

class CreateAuditBase
    include ServiceStack::DTO

    def response_type() = TResponse
    def get_type_name() = 'CreateAuditBase'
end

class CreateAuditTenantBase < CreateAuditBase
end

class UpdateAuditBase
    include ServiceStack::DTO

    def response_type() = TResponse
    def get_type_name() = 'UpdateAuditBase'
end

class UpdateAuditTenantBase < UpdateAuditBase
end

class PatchAuditBase
    include ServiceStack::DTO

    def response_type() = TResponse
    def get_type_name() = 'PatchAuditBase'
end

class PatchAuditTenantBase < PatchAuditBase
end

class SoftDeleteAuditBase
    include ServiceStack::DTO

    def response_type() = TResponse
    def get_type_name() = 'SoftDeleteAuditBase'
end

class SoftDeleteAuditTenantBase < SoftDeleteAuditBase
end

class RockstarVersion < RockstarBase
    # @return [Integer]
    attr_accessor :id
    # @return [Integer]
    attr_accessor :row_version

    def self.properties
        {
            id: { name: 'id' },
            row_version: { name: 'rowVersion' },
        }
    end

end

# @Route("/messages/crud/{Id}", "PUT")
class MessageCrud
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

    def response_type() = nil
    def get_type_name() = 'MessageCrud'
    def get_method() = 'PUT'
end

class QueryResponseAlt
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :offset
    # @return [Integer]
    attr_accessor :total
    # @return [List]
    attr_accessor :results
    # @return [Dictionary]
    attr_accessor :meta
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            offset: { name: 'offset' },
            total: { name: 'total' },
            results: { name: 'results' },
            meta: { name: 'meta' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

#
# Output object for generated text
#
class TextOutput
    include ServiceStack::DTO

    # @ApiMember(Description: "The generated text")
    # @return [String]
    attr_accessor :text

    def self.properties
        {
            text: { name: 'text' },
        }
    end

end

class UploadInfo
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :file_name
    # @return [Integer]
    attr_accessor :content_length
    # @return [String]
    attr_accessor :content_type

    def self.properties
        {
            name: { name: 'name' },
            file_name: { name: 'fileName' },
            content_length: { name: 'contentLength' },
            content_type: { name: 'contentType' },
        }
    end

end

class MetadataTestNestedChild
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

end

class MetadataTestChild
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [List]
    attr_accessor :results

    def self.properties
        {
            name: { name: 'name' },
            results: { name: 'results', type: [MetadataTestNestedChild] },
        }
    end

end

class MenuItemExampleItem
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @ApiMember
    # @return [String]
    attr_accessor :name1

    def self.properties
        {
            name1: { name: 'name1' },
        }
    end

end

class MenuItemExample
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @ApiMember
    # @return [String]
    attr_accessor :name1

    # @return [MenuItemExampleItem]
    attr_accessor :menu_item_example_item

    def self.properties
        {
            name1: { name: 'name1' },
            menu_item_example_item: { name: 'menuItemExampleItem', type: MenuItemExampleItem },
        }
    end

end

# @DataContract
class MenuExample
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @ApiMember
    # @return [MenuItemExample]
    attr_accessor :menu_item_example1

    def self.properties
        {
            menu_item_example1: { name: 'menuItemExample1', type: MenuItemExample },
        }
    end

end

class ListResult
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class ArrayResult
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class HelloResponseBase
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :ref_id

    def self.properties
        {
            ref_id: { name: 'refId' },
        }
    end

end

class HelloWithReturnResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class HelloType
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class InnerType
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

end

class ReturnedDto
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

end

class CustomUserSession < AuthUserSession
    # @return [String]
    attr_accessor :custom_name
    # @return [String]
    attr_accessor :custom_info

    def self.properties
        {
            custom_name: { name: 'customName' },
            custom_info: { name: 'customInfo' },
        }
    end

end

class UnAuthInfo
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :custom_info

    def self.properties
        {
            custom_info: { name: 'customInfo' },
        }
    end

end

#
# Annotations for the message, when applicable, as when using the web search tool.
#
# @DataContract
class UrlCitation
    include ServiceStack::DTO

    # @DataMember(Name="end_index")
    # @return [Integer]
    attr_accessor :end_index

    # @DataMember(Name="start_index")
    # @return [Integer]
    attr_accessor :start_index

    # @DataMember(Name="title")
    # @return [String]
    attr_accessor :title

    # @DataMember(Name="url")
    # @return [String]
    attr_accessor :url

    def self.properties
        {
            end_index: { name: 'end_index' },
            start_index: { name: 'start_index' },
            title: { name: 'title' },
            url: { name: 'url' },
        }
    end

end

#
# Annotations for the message, when applicable, as when using the web search tool.
#
# @DataContract
class ChoiceAnnotation
    include ServiceStack::DTO

    # @DataMember(Name="type")
    # @return [String]
    attr_accessor :type

    # @DataMember(Name="url_citation")
    # @return [UrlCitation]
    attr_accessor :url_citation

    def self.properties
        {
            type: { name: 'type' },
            url_citation: { name: 'url_citation', type: UrlCitation },
        }
    end

end

#
# If the audio output modality is requested, this object contains data about the audio response from the model.
#
# @DataContract
class ChoiceAudio
    include ServiceStack::DTO

    # @DataMember(Name="data")
    # @return [String]
    attr_accessor :data

    # @DataMember(Name="expires_at")
    # @return [Integer]
    attr_accessor :expires_at

    # @DataMember(Name="id")
    # @return [String]
    attr_accessor :id

    # @DataMember(Name="transcript")
    # @return [String]
    attr_accessor :transcript

    def self.properties
        {
            data: { name: 'data' },
            expires_at: { name: 'expires_at' },
            id: { name: 'id' },
            transcript: { name: 'transcript' },
        }
    end

end

# @DataContract
class ChoiceMessage
    include ServiceStack::DTO

    # @DataMember(Name="content")
    # @return [String]
    attr_accessor :content

    # @DataMember(Name="refusal")
    # @return [String]
    attr_accessor :refusal

    # @DataMember(Name="reasoning")
    # @return [String]
    attr_accessor :reasoning

    # @DataMember(Name="reasoning_content")
    # @return [String]
    attr_accessor :reasoning_content

    # @DataMember(Name="thinking")
    # @return [String]
    attr_accessor :thinking

    # @DataMember(Name="role")
    # @return [String]
    attr_accessor :role

    # @DataMember(Name="timestamp")
    # @return [Integer]
    attr_accessor :timestamp

    # @DataMember(Name="tool_call_id")
    # @return [String]
    attr_accessor :tool_call_id

    # @DataMember(Name="images")
    # @return [List]
    attr_accessor :images

    # @DataMember(Name="audios")
    # @return [List]
    attr_accessor :audios

    # @DataMember(Name="files")
    # @return [List]
    attr_accessor :files

    # @DataMember(Name="annotations")
    # @return [List]
    attr_accessor :annotations

    # @DataMember(Name="audio")
    # @return [ChoiceAudio]
    attr_accessor :audio

    # @DataMember(Name="tool_calls")
    # @return [List]
    attr_accessor :tool_calls

    def self.properties
        {
            content: { name: 'content' },
            refusal: { name: 'refusal' },
            reasoning: { name: 'reasoning' },
            reasoning_content: { name: 'reasoning_content' },
            thinking: { name: 'thinking' },
            role: { name: 'role' },
            timestamp: { name: 'timestamp' },
            tool_call_id: { name: 'tool_call_id' },
            images: { name: 'images', type: [AiContent] },
            audios: { name: 'audios', type: [AiContent] },
            files: { name: 'files', type: [AiContent] },
            annotations: { name: 'annotations', type: [ChoiceAnnotation] },
            audio: { name: 'audio', type: ChoiceAudio },
            tool_calls: { name: 'tool_calls', type: [ToolCall] },
        }
    end

end

#
# A list of message content tokens with log probability information.
#
# @DataContract
class LogprobItem
    include ServiceStack::DTO

    # @DataMember(Name="token")
    # @return [String]
    attr_accessor :token

    # @DataMember(Name="logprob")
    # @return [Float]
    attr_accessor :logprob

    # @DataMember(Name="bytes")
    # @return [String]
    attr_accessor :bytes

    # @DataMember(Name="top_logprobs")
    # @return [List]
    attr_accessor :top_logprobs

    def self.properties
        {
            token: { name: 'token' },
            logprob: { name: 'logprob' },
            bytes: { name: 'bytes' },
            top_logprobs: { name: 'top_logprobs', type: [LogprobItem] },
        }
    end

end

#
# Log probability information for the choice.
#
# @DataContract
class Logprobs
    include ServiceStack::DTO

    # @DataMember(Name="content")
    # @return [List]
    attr_accessor :content

    def self.properties
        {
            content: { name: 'content', type: [LogprobItem] },
        }
    end

end

# @DataContract
class Choice
    include ServiceStack::DTO

    # @DataMember(Name="finish_reason")
    # @return [String]
    attr_accessor :finish_reason

    # @DataMember(Name="index")
    # @return [Integer]
    attr_accessor :index

    # @DataMember(Name="message")
    # @return [ChoiceMessage]
    attr_accessor :message

    # @DataMember(Name="logprobs")
    # @return [Logprobs]
    attr_accessor :logprobs

    def self.properties
        {
            finish_reason: { name: 'finish_reason' },
            index: { name: 'index' },
            message: { name: 'message', type: ChoiceMessage },
            logprobs: { name: 'logprobs', type: Logprobs },
        }
    end

end

#
# Usage statistics for the completion request.
#
# @DataContract
class AiCompletionUsage
    include ServiceStack::DTO

    # @DataMember(Name="accepted_prediction_tokens")
    # @return [Integer]
    attr_accessor :accepted_prediction_tokens

    # @DataMember(Name="audio_tokens")
    # @return [Integer]
    attr_accessor :audio_tokens

    # @DataMember(Name="reasoning_tokens")
    # @return [Integer]
    attr_accessor :reasoning_tokens

    # @DataMember(Name="rejected_prediction_tokens")
    # @return [Integer]
    attr_accessor :rejected_prediction_tokens

    def self.properties
        {
            accepted_prediction_tokens: { name: 'accepted_prediction_tokens' },
            audio_tokens: { name: 'audio_tokens' },
            reasoning_tokens: { name: 'reasoning_tokens' },
            rejected_prediction_tokens: { name: 'rejected_prediction_tokens' },
        }
    end

end

#
# Breakdown of tokens used in the prompt.
#
# @DataContract
class AiPromptUsage
    include ServiceStack::DTO

    # @DataMember(Name="accepted_prediction_tokens")
    # @return [Integer]
    attr_accessor :accepted_prediction_tokens

    # @DataMember(Name="audio_tokens")
    # @return [Integer]
    attr_accessor :audio_tokens

    # @DataMember(Name="cached_tokens")
    # @return [Integer]
    attr_accessor :cached_tokens

    def self.properties
        {
            accepted_prediction_tokens: { name: 'accepted_prediction_tokens' },
            audio_tokens: { name: 'audio_tokens' },
            cached_tokens: { name: 'cached_tokens' },
        }
    end

end

#
# Usage statistics for the completion request.
#
# @DataContract
class AiUsage
    include ServiceStack::DTO

    # @DataMember(Name="completion_tokens")
    # @return [Integer]
    attr_accessor :completion_tokens

    # @DataMember(Name="prompt_tokens")
    # @return [Integer]
    attr_accessor :prompt_tokens

    # @DataMember(Name="total_tokens")
    # @return [Integer]
    attr_accessor :total_tokens

    # @DataMember(Name="completion_tokens_details")
    # @return [AiCompletionUsage]
    attr_accessor :completion_tokens_details

    # @DataMember(Name="prompt_tokens_details")
    # @return [AiPromptUsage]
    attr_accessor :prompt_tokens_details

    # @DataMember(Name="duration")
    # @return [Integer]
    attr_accessor :duration

    def self.properties
        {
            completion_tokens: { name: 'completion_tokens' },
            prompt_tokens: { name: 'prompt_tokens' },
            total_tokens: { name: 'total_tokens' },
            completion_tokens_details: { name: 'completion_tokens_details', type: AiCompletionUsage },
            prompt_tokens_details: { name: 'prompt_tokens_details', type: AiPromptUsage },
            duration: { name: 'duration' },
        }
    end

end

class TypesGroup
    include ServiceStack::DTO

end

#
# Text content part
#
# @DataContract
class AiTextContent < AiContent
    # @DataMember(Name="text")
    # @return [String]
    attr_accessor :text

    def self.properties
        {
            text: { name: 'text' },
        }
    end

end

# @DataContract
class AiImageUrl
    include ServiceStack::DTO

    # @DataMember(Name="url")
    # @return [String]
    attr_accessor :url

    def self.properties
        {
            url: { name: 'url' },
        }
    end

end

#
# Image content part
#
# @DataContract
class AiImageContent < AiContent
    # @DataMember(Name="image_url")
    # @return [AiImageUrl]
    attr_accessor :image_url

    def self.properties
        {
            image_url: { name: 'image_url', type: AiImageUrl },
        }
    end

end

#
# Audio content part
#
# @DataContract
class AiInputAudio
    include ServiceStack::DTO

    # @DataMember(Name="data")
    # @return [String]
    attr_accessor :data

    # @DataMember(Name="format")
    # @return [String]
    attr_accessor :format

    def self.properties
        {
            data: { name: 'data' },
            format: { name: 'format' },
        }
    end

end

#
# Audio content part
#
# @DataContract
class AiAudioContent < AiContent
    # @DataMember(Name="input_audio")
    # @return [AiInputAudio]
    attr_accessor :input_audio

    def self.properties
        {
            input_audio: { name: 'input_audio', type: AiInputAudio },
        }
    end

end

#
# File content part
#
# @DataContract
class AiFile
    include ServiceStack::DTO

    # @DataMember(Name="file_data")
    # @return [String]
    attr_accessor :file_data

    # @DataMember(Name="filename")
    # @return [String]
    attr_accessor :filename

    # @DataMember(Name="file_id")
    # @return [String]
    attr_accessor :file_id

    def self.properties
        {
            file_data: { name: 'file_data' },
            filename: { name: 'filename' },
            file_id: { name: 'file_id' },
        }
    end

end

#
# File content part
#
# @DataContract
class AiFileContent < AiContent
    # @DataMember(Name="file")
    # @return [AiFile]
    attr_accessor :file

    def self.properties
        {
            file: { name: 'file', type: AiFile },
        }
    end

end

# @DataContract
class AiAudioUrl
    include ServiceStack::DTO

    # @DataMember(Name="url")
    # @return [String]
    attr_accessor :url

    def self.properties
        {
            url: { name: 'url' },
        }
    end

end

#
# Generated audio content part, referenced by URL (emitted by tool calls and audio models)
#
# @DataContract
class AiAudioUrlContent < AiContent
    # @DataMember(Name="audio_url")
    # @return [AiAudioUrl]
    attr_accessor :audio_url

    def self.properties
        {
            audio_url: { name: 'audio_url', type: AiAudioUrl },
        }
    end

end

class ChatMessage
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :channel
    # @return [String]
    attr_accessor :from_user_id
    # @return [String]
    attr_accessor :from_name
    # @return [String]
    attr_accessor :display_name
    # @return [String]
    attr_accessor :message
    # @return [String]
    attr_accessor :user_auth_id
    # @return [TrueClass]
    attr_accessor :private

    def self.properties
        {
            id: { name: 'id' },
            channel: { name: 'channel' },
            from_user_id: { name: 'fromUserId' },
            from_name: { name: 'fromName' },
            display_name: { name: 'displayName' },
            message: { name: 'message' },
            user_auth_id: { name: 'userAuthId' },
            private: { name: 'private' },
        }
    end

end

class GetChatHistoryResponse
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :results
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            results: { name: 'results', type: [ChatMessage] },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class GetUserDetailsResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :provider
    # @return [String]
    attr_accessor :user_id
    # @return [String]
    attr_accessor :user_name
    # @return [String]
    attr_accessor :full_name
    # @return [String]
    attr_accessor :display_name
    # @return [String]
    attr_accessor :first_name
    # @return [String]
    attr_accessor :last_name
    # @return [String]
    attr_accessor :company
    # @return [String]
    attr_accessor :email
    # @return [String]
    attr_accessor :phone_number
    # @return [DateTime]
    attr_accessor :birth_date
    # @return [String]
    attr_accessor :birth_date_raw
    # @return [String]
    attr_accessor :address
    # @return [String]
    attr_accessor :address2
    # @return [String]
    attr_accessor :city
    # @return [String]
    attr_accessor :state
    # @return [String]
    attr_accessor :country
    # @return [String]
    attr_accessor :culture
    # @return [String]
    attr_accessor :gender
    # @return [String]
    attr_accessor :language
    # @return [String]
    attr_accessor :mail_address
    # @return [String]
    attr_accessor :nickname
    # @return [String]
    attr_accessor :postal_code
    # @return [String]
    attr_accessor :time_zone

    def self.properties
        {
            provider: { name: 'provider' },
            user_id: { name: 'userId' },
            user_name: { name: 'userName' },
            full_name: { name: 'fullName' },
            display_name: { name: 'displayName' },
            first_name: { name: 'firstName' },
            last_name: { name: 'lastName' },
            company: { name: 'company' },
            email: { name: 'email' },
            phone_number: { name: 'phoneNumber' },
            birth_date: { name: 'birthDate', type: DateTime },
            birth_date_raw: { name: 'birthDateRaw' },
            address: { name: 'address' },
            address2: { name: 'address2' },
            city: { name: 'city' },
            state: { name: 'state' },
            country: { name: 'country' },
            culture: { name: 'culture' },
            gender: { name: 'gender' },
            language: { name: 'language' },
            mail_address: { name: 'mailAddress' },
            nickname: { name: 'nickname' },
            postal_code: { name: 'postalCode' },
            time_zone: { name: 'timeZone' },
        }
    end

end

class CustomHttpErrorResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :custom
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            custom: { name: 'custom' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class Items
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :results

    def self.properties
        {
            results: { name: 'results', type: [Item] },
        }
    end

end

class ReturnCustom400Response
    include ServiceStack::DTO

    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class ThrowTypeResponse
    include ServiceStack::DTO

    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class ThrowValidationResponse
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :age
    # @return [String]
    attr_accessor :required
    # @return [String]
    attr_accessor :email
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            age: { name: 'age' },
            required: { name: 'required' },
            email: { name: 'email' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class ThrowBusinessErrorResponse
    include ServiceStack::DTO

    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

#
# Response object for text generation requests
#
# @Api(Description: "Response object for text generation requests")
class TextGenerationResponse
    include ServiceStack::DTO

    # @ApiMember(Description: "List of generated text outputs")
    # @return [List]
    attr_accessor :results

    # @ApiMember(Description: "Detailed response status information")
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            results: { name: 'results', type: [TextOutput] },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class TestFileUploadsResponse
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :ref_id
    # @return [List]
    attr_accessor :files
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            id: { name: 'id' },
            ref_id: { name: 'refId' },
            files: { name: 'files', type: [UploadInfo] },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class TestUploadWithDto
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :int
    # @return [Integer]
    attr_accessor :nullable_id
    # @return [Integer]
    attr_accessor :long
    # @return [Float]
    attr_accessor :double
    # @return [String]
    attr_accessor :string
    # @return [DateTime]
    attr_accessor :date_time
    # @return [Array]
    attr_accessor :int_array
    # @return [List]
    attr_accessor :int_list
    # @return [Array]
    attr_accessor :string_array
    # @return [List]
    attr_accessor :string_list
    # @return [Array]
    attr_accessor :poco_array
    # @return [List]
    attr_accessor :poco_list
    # @return [Array]
    attr_accessor :nullable_byte_array
    # @return [List]
    attr_accessor :nullable_byte_list
    # @return [Array]
    attr_accessor :nullable_date_time_array
    # @return [List]
    attr_accessor :nullable_date_time_list
    # @return [Dictionary]
    attr_accessor :poco_lookup
    # @return [Dictionary]
    attr_accessor :poco_lookup_map
    # @return [Dictionary]
    attr_accessor :map_list

    def self.properties
        {
            int: { name: 'int' },
            nullable_id: { name: 'nullableId' },
            long: { name: 'long' },
            double: { name: 'double' },
            string: { name: 'string' },
            date_time: { name: 'dateTime', type: DateTime },
            int_array: { name: 'intArray' },
            int_list: { name: 'intList' },
            string_array: { name: 'stringArray' },
            string_list: { name: 'stringList' },
            poco_array: { name: 'pocoArray', type: [Poco] },
            poco_list: { name: 'pocoList', type: [Poco] },
            nullable_byte_array: { name: 'nullableByteArray' },
            nullable_byte_list: { name: 'nullableByteList' },
            nullable_date_time_array: { name: 'nullableDateTimeArray' },
            nullable_date_time_list: { name: 'nullableDateTimeList' },
            poco_lookup: { name: 'pocoLookup' },
            poco_lookup_map: { name: 'pocoLookupMap' },
            map_list: { name: 'mapList' },
        }
    end

    def response_type() = TestUploadWithDto
    def get_type_name() = 'TestUploadWithDto'
    def get_method() = 'POST'
end

class Account
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

end

class Project
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :account
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            account: { name: 'account' },
            name: { name: 'name' },
        }
    end

end

class SecuredResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            result: { name: 'result' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class CreateJwtResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :token
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            token: { name: 'token' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class CreateRefreshJwtResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :token
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            token: { name: 'token' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class MetadataTestResponse
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [List]
    attr_accessor :results

    def self.properties
        {
            id: { name: 'id' },
            results: { name: 'results', type: [MetadataTestChild] },
        }
    end

end

# @DataContract
class GetExampleResponse
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    # @DataMember(Order=2)
    # @ApiMember
    # @return [MenuExample]
    attr_accessor :menu_example1

    def self.properties
        {
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
            menu_example1: { name: 'menuExample1', type: MenuExample },
        }
    end

end

# @Route("/messages/{Id}", "PUT")
class Message
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
        }
    end

    def response_type() = Message
    def get_type_name() = 'Message'
    def get_method() = 'PUT'
end

class GetRandomIdsResponse
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :results

    def self.properties
        {
            results: { name: 'results' },
        }
    end

end

class HelloResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class AllTypes
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [Integer]
    attr_accessor :nullable_id
    # @return [Integer]
    attr_accessor :byte
    # @return [Integer]
    attr_accessor :short
    # @return [Integer]
    attr_accessor :int
    # @return [Integer]
    attr_accessor :long
    # @return [Integer]
    attr_accessor :u_short
    # @return [Integer]
    attr_accessor :u_int
    # @return [Integer]
    attr_accessor :u_long
    # @return [Float]
    attr_accessor :float
    # @return [Float]
    attr_accessor :double
    # @return [BigDecimal]
    attr_accessor :decimal
    # @return [String]
    attr_accessor :string
    # @return [DateTime]
    attr_accessor :date_time
    # @return [Time]
    attr_accessor :time_span
    # @return [DateTime]
    attr_accessor :date_time_offset
    # @return [String]
    attr_accessor :guid
    # @return [String]
    attr_accessor :char
    # @return [KeyValuePair]
    attr_accessor :key_value_pair
    # @return [DateTime]
    attr_accessor :nullable_date_time
    # @return [Time]
    attr_accessor :nullable_time_span
    # @return [List]
    attr_accessor :string_list
    # @return [Array]
    attr_accessor :string_array
    # @return [Dictionary]
    attr_accessor :string_map
    # @return [Dictionary]
    attr_accessor :int_string_map
    # @return [SubType]
    attr_accessor :sub_type

    def self.properties
        {
            id: { name: 'id' },
            nullable_id: { name: 'nullableId' },
            byte: { name: 'byte' },
            short: { name: 'short' },
            int: { name: 'int' },
            long: { name: 'long' },
            u_short: { name: 'uShort' },
            u_int: { name: 'uInt' },
            u_long: { name: 'uLong' },
            float: { name: 'float' },
            double: { name: 'double' },
            decimal: { name: 'decimal' },
            string: { name: 'string' },
            date_time: { name: 'dateTime', type: DateTime },
            time_span: { name: 'timeSpan' },
            date_time_offset: { name: 'dateTimeOffset', type: DateTime },
            guid: { name: 'guid' },
            char: { name: 'char' },
            key_value_pair: { name: 'keyValuePair', type: KeyValuePair },
            nullable_date_time: { name: 'nullableDateTime', type: DateTime },
            nullable_time_span: { name: 'nullableTimeSpan' },
            string_list: { name: 'stringList' },
            string_array: { name: 'stringArray' },
            string_map: { name: 'stringMap' },
            int_string_map: { name: 'intStringMap' },
            sub_type: { name: 'subType', type: SubType },
        }
    end

    def response_type() = AllTypes
    def get_type_name() = 'AllTypes'
    def get_method() = 'POST'
end

class AllCollectionTypes
    include ServiceStack::DTO

    # @return [Array]
    attr_accessor :int_array
    # @return [List]
    attr_accessor :int_list
    # @return [Array]
    attr_accessor :string_array
    # @return [List]
    attr_accessor :string_list
    # @return [Array]
    attr_accessor :float_array
    # @return [List]
    attr_accessor :double_list
    # @return [String]
    attr_accessor :byte_array
    # @return [Array]
    attr_accessor :char_array
    # @return [List]
    attr_accessor :decimal_list
    # @return [Array]
    attr_accessor :poco_array
    # @return [List]
    attr_accessor :poco_list
    # @return [Dictionary]
    attr_accessor :poco_lookup
    # @return [Dictionary]
    attr_accessor :poco_lookup_map

    def self.properties
        {
            int_array: { name: 'intArray' },
            int_list: { name: 'intList' },
            string_array: { name: 'stringArray' },
            string_list: { name: 'stringList' },
            float_array: { name: 'floatArray' },
            double_list: { name: 'doubleList' },
            byte_array: { name: 'byteArray' },
            char_array: { name: 'charArray' },
            decimal_list: { name: 'decimalList' },
            poco_array: { name: 'pocoArray', type: [Poco] },
            poco_list: { name: 'pocoList', type: [Poco] },
            poco_lookup: { name: 'pocoLookup' },
            poco_lookup_map: { name: 'pocoLookupMap' },
        }
    end

    def response_type() = AllCollectionTypes
    def get_type_name() = 'AllCollectionTypes'
    def get_method() = 'POST'
end

class HelloAllTypesResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result
    # @return [AllTypes]
    attr_accessor :all_types
    # @return [AllCollectionTypes]
    attr_accessor :all_collection_types

    def self.properties
        {
            result: { name: 'result' },
            all_types: { name: 'allTypes', type: AllTypes },
            all_collection_types: { name: 'allCollectionTypes', type: AllCollectionTypes },
        }
    end

end

class SubAllTypes < AllTypesBase
    # @return [Integer]
    attr_accessor :hierarchy

    def self.properties
        {
            hierarchy: { name: 'hierarchy' },
        }
    end

end

class HelloDateTime
    include ServiceStack::DTO

    # @return [DateTime]
    attr_accessor :date_time

    def self.properties
        {
            date_time: { name: 'dateTime', type: DateTime },
        }
    end

    def response_type() = HelloDateTime
    def get_type_name() = 'HelloDateTime'
    def get_method() = 'POST'
end

# @DataContract
class HelloWithDataContractResponse
    include ServiceStack::DTO

    # @DataMember(Name="result", Order=1, IsRequired=true, EmitDefaultValue=false)
    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

#
# Description on HelloWithDescriptionResponse type
#
class HelloWithDescriptionResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class HelloWithInheritanceResponse < HelloResponseBase
    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class HelloWithAlternateReturnResponse < HelloWithReturnResponse
    # @return [String]
    attr_accessor :alt_result

    def self.properties
        {
            alt_result: { name: 'altResult' },
        }
    end

end

class HelloWithRouteResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class HelloWithTypeResponse
    include ServiceStack::DTO

    # @return [HelloType]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result', type: HelloType },
        }
    end

end

class HelloInnerTypesResponse
    include ServiceStack::DTO

    # @return [InnerType]
    attr_accessor :inner_type
    # @return [InnerEnum]
    attr_accessor :inner_enum

    def self.properties
        {
            inner_type: { name: 'innerType', type: InnerType },
            inner_enum: { name: 'innerEnum' },
        }
    end

end

class HelloVerbResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class EnumResponse
    include ServiceStack::DTO

    # @return [ScopeType]
    attr_accessor :operator

    def self.properties
        {
            operator: { name: 'operator' },
        }
    end

end

# @Route("/hellotypes/{Name}")
class HelloTypes
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :string
    # @return [TrueClass]
    attr_accessor :bool
    # @return [Integer]
    attr_accessor :int

    def self.properties
        {
            string: { name: 'string' },
            bool: { name: 'bool' },
            int: { name: 'int' },
        }
    end

    def response_type() = HelloTypes
    def get_type_name() = 'HelloTypes'
    def get_method() = 'POST'
end

# @DataContract
class HelloZipResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class PingResponse
    include ServiceStack::DTO

    # @return [Dictionary]
    attr_accessor :responses
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            responses: { name: 'responses', type: { String => ServiceStack::ResponseStatus } },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class RequiresRoleResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :result
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            result: { name: 'result' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class SendVerbResponse
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :path_info
    # @return [String]
    attr_accessor :request_method

    def self.properties
        {
            id: { name: 'id' },
            path_info: { name: 'pathInfo' },
            request_method: { name: 'requestMethod' },
        }
    end

end

class GetSessionResponse
    include ServiceStack::DTO

    # @return [CustomUserSession]
    attr_accessor :result
    # @return [UnAuthInfo]
    attr_accessor :un_auth_info
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            result: { name: 'result', type: CustomUserSession },
            un_auth_info: { name: 'unAuthInfo', type: UnAuthInfo },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

# @DataContract(Namespace="http://schemas.servicestack.net/types")
class GetStuffResponse
    include ServiceStack::DTO

    # @return [DateTime]
    attr_accessor :summary_date
    # @return [DateTime]
    attr_accessor :summary_end_date
    # @return [String]
    attr_accessor :symbol
    # @return [String]
    attr_accessor :email
    # @return [TrueClass]
    attr_accessor :is_enabled

    def self.properties
        {
            summary_date: { name: 'summaryDate', type: DateTime },
            summary_end_date: { name: 'summaryEndDate', type: DateTime },
            symbol: { name: 'symbol' },
            email: { name: 'email' },
            is_enabled: { name: 'isEnabled' },
        }
    end

end

class StoreLogsResponse
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :existing_logs
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            existing_logs: { name: 'existingLogs', type: [Logger] },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class TestAuthResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :user_id
    # @return [String]
    attr_accessor :session_id
    # @return [String]
    attr_accessor :user_name
    # @return [String]
    attr_accessor :display_name
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            user_id: { name: 'userId' },
            session_id: { name: 'sessionId' },
            user_name: { name: 'userName' },
            display_name: { name: 'displayName' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class RequiresAdmin
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = RequiresAdmin
    def get_type_name() = 'RequiresAdmin'
    def get_method() = 'POST'
end

# @Route("/custom")
class CustomRoute
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :data

    def self.properties
        {
            data: { name: 'data' },
        }
    end

    def response_type() = CustomRoute
    def get_type_name() = 'CustomRoute'
    def get_method() = 'POST'
end

# @Route("/wait/{ForMs}")
class Wait
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :for_ms

    def self.properties
        {
            for_ms: { name: 'forMs' },
        }
    end

    def response_type() = Wait
    def get_type_name() = 'Wait'
    def get_method() = 'POST'
end

# @Route("/echo/types")
class EchoTypes
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :byte
    # @return [Integer]
    attr_accessor :short
    # @return [Integer]
    attr_accessor :int
    # @return [Integer]
    attr_accessor :long
    # @return [Integer]
    attr_accessor :u_short
    # @return [Integer]
    attr_accessor :u_int
    # @return [Integer]
    attr_accessor :u_long
    # @return [Float]
    attr_accessor :float
    # @return [Float]
    attr_accessor :double
    # @return [BigDecimal]
    attr_accessor :decimal
    # @return [String]
    attr_accessor :string
    # @return [DateTime]
    attr_accessor :date_time
    # @return [Time]
    attr_accessor :time_span
    # @return [DateTime]
    attr_accessor :date_time_offset
    # @return [String]
    attr_accessor :guid
    # @return [String]
    attr_accessor :char

    def self.properties
        {
            byte: { name: 'byte' },
            short: { name: 'short' },
            int: { name: 'int' },
            long: { name: 'long' },
            u_short: { name: 'uShort' },
            u_int: { name: 'uInt' },
            u_long: { name: 'uLong' },
            float: { name: 'float' },
            double: { name: 'double' },
            decimal: { name: 'decimal' },
            string: { name: 'string' },
            date_time: { name: 'dateTime', type: DateTime },
            time_span: { name: 'timeSpan' },
            date_time_offset: { name: 'dateTimeOffset', type: DateTime },
            guid: { name: 'guid' },
            char: { name: 'char' },
        }
    end

    def response_type() = EchoTypes
    def get_type_name() = 'EchoTypes'
    def get_method() = 'POST'
end

# @Route("/echo/collections")
class EchoCollections
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :string_list
    # @return [Array]
    attr_accessor :string_array
    # @return [Dictionary]
    attr_accessor :string_map
    # @return [Dictionary]
    attr_accessor :int_string_map

    def self.properties
        {
            string_list: { name: 'stringList' },
            string_array: { name: 'stringArray' },
            string_map: { name: 'stringMap' },
            int_string_map: { name: 'intStringMap' },
        }
    end

    def response_type() = EchoCollections
    def get_type_name() = 'EchoCollections'
    def get_method() = 'POST'
end

# @Route("/echo/complex")
class EchoComplexTypes
    include ServiceStack::DTO

    # @return [SubType]
    attr_accessor :sub_type
    # @return [List]
    attr_accessor :sub_types
    # @return [Dictionary]
    attr_accessor :sub_type_map
    # @return [Dictionary]
    attr_accessor :string_map
    # @return [Dictionary]
    attr_accessor :int_string_map

    def self.properties
        {
            sub_type: { name: 'subType', type: SubType },
            sub_types: { name: 'subTypes', type: [SubType] },
            sub_type_map: { name: 'subTypeMap', type: { String => SubType } },
            string_map: { name: 'stringMap' },
            int_string_map: { name: 'intStringMap' },
        }
    end

    def response_type() = EchoComplexTypes
    def get_type_name() = 'EchoComplexTypes'
    def get_method() = 'POST'
end

# @Route("/rockstars", "POST")
class StoreRockstars < Array
    def self.from_hash(json) = new.replace(ServiceStack::DTO::Serializer.from_json_value([Rockstar], json))

    def response_type() = StoreRockstars
    def get_type_name() = 'StoreRockstars'
    def get_method() = 'POST'
end

# @DataContract
class AssignRolesResponse
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [List]
    attr_accessor :all_roles

    # @DataMember(Order=2)
    # @return [List]
    attr_accessor :all_permissions

    # @DataMember(Order=3)
    # @return [Dictionary]
    attr_accessor :meta

    # @DataMember(Order=4)
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            all_roles: { name: 'allRoles' },
            all_permissions: { name: 'allPermissions' },
            meta: { name: 'meta' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

# @DataContract
class UnAssignRolesResponse
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [List]
    attr_accessor :all_roles

    # @DataMember(Order=2)
    # @return [List]
    attr_accessor :all_permissions

    # @DataMember(Order=3)
    # @return [Dictionary]
    attr_accessor :meta

    # @DataMember(Order=4)
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            all_roles: { name: 'allRoles' },
            all_permissions: { name: 'allPermissions' },
            meta: { name: 'meta' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

# @DataContract
class ChatResponse
    include ServiceStack::DTO

    # @DataMember(Name="id")
    # @return [String]
    attr_accessor :id

    # @DataMember(Name="choices")
    # @return [List]
    attr_accessor :choices

    # @DataMember(Name="created")
    # @return [Integer]
    attr_accessor :created

    # @DataMember(Name="model")
    # @return [String]
    attr_accessor :model

    # @DataMember(Name="system_fingerprint")
    # @return [String]
    attr_accessor :system_fingerprint

    # @DataMember(Name="object")
    # @return [String]
    attr_accessor :object

    # @DataMember(Name="service_tier")
    # @return [String]
    attr_accessor :service_tier

    # @DataMember(Name="usage")
    # @return [AiUsage]
    attr_accessor :usage

    # @DataMember(Name="provider")
    # @return [String]
    attr_accessor :provider

    # @DataMember(Name="cost")
    # @return [Float]
    attr_accessor :cost

    # @DataMember(Name="tool_history")
    # @return [List]
    attr_accessor :tool_history

    # @DataMember(Name="metadata")
    # @return [Dictionary]
    attr_accessor :metadata

    # @DataMember(Name="responseStatus")
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            id: { name: 'id' },
            choices: { name: 'choices', type: [Choice] },
            created: { name: 'created' },
            model: { name: 'model' },
            system_fingerprint: { name: 'system_fingerprint' },
            object: { name: 'object' },
            service_tier: { name: 'service_tier' },
            usage: { name: 'usage', type: AiUsage },
            provider: { name: 'provider' },
            cost: { name: 'cost' },
            tool_history: { name: 'tool_history', type: [ChoiceMessage] },
            metadata: { name: 'metadata' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class RockstarWithIdResponse
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            id: { name: 'id' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class RockstarWithIdAndResultResponse
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [RockstarAuto]
    attr_accessor :result
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            id: { name: 'id' },
            result: { name: 'result', type: RockstarAuto },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class RockstarWithIdAndCountResponse
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [Integer]
    attr_accessor :count
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            id: { name: 'id' },
            count: { name: 'count' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class RockstarWithIdAndRowVersionResponse
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [Integer]
    attr_accessor :row_version
    # @return [ServiceStack::ResponseStatus]
    attr_accessor :response_status

    def self.properties
        {
            id: { name: 'id' },
            row_version: { name: 'rowVersion' },
            response_status: { name: 'responseStatus', type: ServiceStack::ResponseStatus },
        }
    end

end

class QueryItems < ServiceStack::QueryDb
    def response_type() = ServiceStack::QueryResponse.of(Poco)
    def get_type_name() = 'QueryItems'
    def get_method() = 'GET'
end

# @Route("/channels/{Channel}/raw")
class PostRawToChannel
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :from
    # @return [String]
    attr_accessor :to_user_id
    # @return [String]
    attr_accessor :channel
    # @return [String]
    attr_accessor :message
    # @return [String]
    attr_accessor :selector

    def self.properties
        {
            from: { name: 'from' },
            to_user_id: { name: 'toUserId' },
            channel: { name: 'channel' },
            message: { name: 'message' },
            selector: { name: 'selector' },
        }
    end

    def response_type() = nil
    def get_type_name() = 'PostRawToChannel'
    def get_method() = 'POST'
end

# @Route("/channels/{Channel}/chat")
class PostChatToChannel
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :from
    # @return [String]
    attr_accessor :to_user_id
    # @return [String]
    attr_accessor :channel
    # @return [String]
    attr_accessor :message
    # @return [String]
    attr_accessor :selector

    def self.properties
        {
            from: { name: 'from' },
            to_user_id: { name: 'toUserId' },
            channel: { name: 'channel' },
            message: { name: 'message' },
            selector: { name: 'selector' },
        }
    end

    def response_type() = ChatMessage
    def get_type_name() = 'PostChatToChannel'
    def get_method() = 'POST'
end

# @Route("/chathistory")
class GetChatHistory
    include ServiceStack::DTO

    # @return [Array]
    attr_accessor :channels
    # @return [Integer]
    attr_accessor :after_id
    # @return [Integer]
    attr_accessor :take

    def self.properties
        {
            channels: { name: 'channels' },
            after_id: { name: 'afterId' },
            take: { name: 'take' },
        }
    end

    def response_type() = GetChatHistoryResponse
    def get_type_name() = 'GetChatHistory'
    def get_method() = 'POST'
end

# @Route("/reset")
class ClearChatHistory
    include ServiceStack::DTO

    def response_type() = nil
    def get_type_name() = 'ClearChatHistory'
    def get_method() = 'POST'
end

# @Route("/reset-serverevents")
class ResetServerEvents
    include ServiceStack::DTO

    def response_type() = nil
    def get_type_name() = 'ResetServerEvents'
    def get_method() = 'POST'
end

# @Route("/channels/{Channel}/object")
class PostObjectToChannel
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :to_user_id
    # @return [String]
    attr_accessor :channel
    # @return [String]
    attr_accessor :selector
    # @return [CustomType]
    attr_accessor :custom_type
    # @return [SetterType]
    attr_accessor :setter_type

    def self.properties
        {
            to_user_id: { name: 'toUserId' },
            channel: { name: 'channel' },
            selector: { name: 'selector' },
            custom_type: { name: 'customType', type: CustomType },
            setter_type: { name: 'setterType', type: SetterType },
        }
    end

    def response_type() = nil
    def get_type_name() = 'PostObjectToChannel'
    def get_method() = 'POST'
end

# @Route("/account")
class GetUserDetails
    include ServiceStack::DTO

    def response_type() = GetUserDetailsResponse
    def get_type_name() = 'GetUserDetails'
    def get_method() = 'GET'
end

class CustomHttpError
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :status_code
    # @return [String]
    attr_accessor :status_description

    def self.properties
        {
            status_code: { name: 'statusCode' },
            status_description: { name: 'statusDescription' },
        }
    end

    def response_type() = CustomHttpErrorResponse
    def get_type_name() = 'CustomHttpError'
    def get_method() = 'POST'
end

class AltQueryItems
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = QueryResponseAlt
    def get_type_name() = 'AltQueryItems'
    def get_method() = 'POST'
end

class GetItems
    include ServiceStack::DTO

    def response_type() = Items
    def get_type_name() = 'GetItems'
    def get_method() = 'GET'
end

class GetNakedItems
    include ServiceStack::DTO

    def response_type() = List
    def get_type_name() = 'GetNakedItems'
    def get_method() = 'GET'
end

# @ValidateRequest(Validator: "IsAuthenticated")
class DeclarativeValidationAuth
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

end

class DeclarativeCollectiveValidationTest
    include ServiceStack::DTO

    # @Validate(Validator: "NotEmpty")
    # @return [String]
    attr_accessor :site

    # @return [List]
    attr_accessor :declarative_validations
    # @return [List]
    attr_accessor :fluent_validations

    def self.properties
        {
            site: { name: 'site' },
            declarative_validations: { name: 'declarativeValidations', type: [DeclarativeChildValidation] },
            fluent_validations: { name: 'fluentValidations', type: [FluentChildValidation] },
        }
    end

    def response_type() = ServiceStack::EmptyResponse
    def get_type_name() = 'DeclarativeCollectiveValidationTest'
    def get_method() = 'POST'
end

class DeclarativeSingleValidationTest
    include ServiceStack::DTO

    # @Validate(Validator: "NotEmpty")
    # @return [String]
    attr_accessor :site

    # @return [DeclarativeSingleValidation]
    attr_accessor :declarative_single_validation
    # @return [FluentSingleValidation]
    attr_accessor :fluent_single_validation

    def self.properties
        {
            site: { name: 'site' },
            declarative_single_validation: { name: 'declarativeSingleValidation', type: DeclarativeSingleValidation },
            fluent_single_validation: { name: 'fluentSingleValidation', type: FluentSingleValidation },
        }
    end

    def response_type() = ServiceStack::EmptyResponse
    def get_type_name() = 'DeclarativeSingleValidationTest'
    def get_method() = 'POST'
end

class DummyTypes
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :hello_responses
    # @return [List]
    attr_accessor :list_result
    # @return [Array]
    attr_accessor :array_result
    # @return [CancelRequest]
    attr_accessor :cancel_request
    # @return [CancelRequestResponse]
    attr_accessor :cancel_request_response
    # @return [UpdateEventSubscriber]
    attr_accessor :update_event_subscriber
    # @return [UpdateEventSubscriberResponse]
    attr_accessor :update_event_subscriber_response
    # @return [GetApiKeys]
    attr_accessor :get_api_keys
    # @return [GetApiKeysResponse]
    attr_accessor :get_api_keys_response
    # @return [RegenerateApiKeys]
    attr_accessor :regenerate_api_keys
    # @return [RegenerateApiKeysResponse]
    attr_accessor :regenerate_api_keys_response
    # @return [UserApiKey]
    attr_accessor :user_api_key
    # @return [ServiceStack::ConvertSessionToToken]
    attr_accessor :convert_session_to_token
    # @return [ServiceStack::ConvertSessionToTokenResponse]
    attr_accessor :convert_session_to_token_response
    # @return [ServiceStack::GetAccessToken]
    attr_accessor :get_access_token
    # @return [ServiceStack::GetAccessTokenResponse]
    attr_accessor :get_access_token_response
    # @return [NavItem]
    attr_accessor :nav_item
    # @return [GetNavItems]
    attr_accessor :get_nav_items
    # @return [GetNavItemsResponse]
    attr_accessor :get_nav_items_response
    # @return [ServiceStack::EmptyResponse]
    attr_accessor :empty_response
    # @return [ServiceStack::IdResponse]
    attr_accessor :id_response
    # @return [ServiceStack::StringResponse]
    attr_accessor :string_response
    # @return [ServiceStack::StringsResponse]
    attr_accessor :strings_response
    # @return [ServiceStack::AuditBase]
    attr_accessor :audit_base

    def self.properties
        {
            hello_responses: { name: 'helloResponses', type: [HelloResponse] },
            list_result: { name: 'listResult', type: [ListResult] },
            array_result: { name: 'arrayResult', type: [ArrayResult] },
            cancel_request: { name: 'cancelRequest', type: CancelRequest },
            cancel_request_response: { name: 'cancelRequestResponse', type: CancelRequestResponse },
            update_event_subscriber: { name: 'updateEventSubscriber', type: UpdateEventSubscriber },
            update_event_subscriber_response: { name: 'updateEventSubscriberResponse', type: UpdateEventSubscriberResponse },
            get_api_keys: { name: 'getApiKeys', type: GetApiKeys },
            get_api_keys_response: { name: 'getApiKeysResponse', type: GetApiKeysResponse },
            regenerate_api_keys: { name: 'regenerateApiKeys', type: RegenerateApiKeys },
            regenerate_api_keys_response: { name: 'regenerateApiKeysResponse', type: RegenerateApiKeysResponse },
            user_api_key: { name: 'userApiKey', type: UserApiKey },
            convert_session_to_token: { name: 'convertSessionToToken', type: ServiceStack::ConvertSessionToToken },
            convert_session_to_token_response: { name: 'convertSessionToTokenResponse', type: ServiceStack::ConvertSessionToTokenResponse },
            get_access_token: { name: 'getAccessToken', type: ServiceStack::GetAccessToken },
            get_access_token_response: { name: 'getAccessTokenResponse', type: ServiceStack::GetAccessTokenResponse },
            nav_item: { name: 'navItem', type: NavItem },
            get_nav_items: { name: 'getNavItems', type: GetNavItems },
            get_nav_items_response: { name: 'getNavItemsResponse', type: GetNavItemsResponse },
            empty_response: { name: 'emptyResponse', type: ServiceStack::EmptyResponse },
            id_response: { name: 'idResponse', type: ServiceStack::IdResponse },
            string_response: { name: 'stringResponse', type: ServiceStack::StringResponse },
            strings_response: { name: 'stringsResponse', type: ServiceStack::StringsResponse },
            audit_base: { name: 'auditBase', type: ServiceStack::AuditBase },
        }
    end

end

# @Route("/throwhttperror/{Status}")
class ThrowHttpError
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :status
    # @return [String]
    attr_accessor :message

    def self.properties
        {
            status: { name: 'status' },
            message: { name: 'message' },
        }
    end

end

# @Route("/throw404")
class Throw404
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :message

    def self.properties
        {
            message: { name: 'message' },
        }
    end

end

# @Route("/throwcustom400")
class ThrowCustom400
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :message

    def self.properties
        {
            message: { name: 'message' },
        }
    end

end

# @Route("/returncustom400")
class ReturnCustom400
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :message

    def self.properties
        {
            message: { name: 'message' },
        }
    end

    def response_type() = ReturnCustom400Response
    def get_type_name() = 'ReturnCustom400'
    def get_method() = 'POST'
end

# @Route("/throw/{Type}")
class ThrowType
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :type
    # @return [String]
    attr_accessor :message

    def self.properties
        {
            type: { name: 'type' },
            message: { name: 'message' },
        }
    end

    def response_type() = ThrowTypeResponse
    def get_type_name() = 'ThrowType'
    def get_method() = 'POST'
end

# @Route("/throwvalidation")
class ThrowValidation
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :age
    # @return [String]
    attr_accessor :required
    # @return [String]
    attr_accessor :email

    def self.properties
        {
            age: { name: 'age' },
            required: { name: 'required' },
            email: { name: 'email' },
        }
    end

    def response_type() = ThrowValidationResponse
    def get_type_name() = 'ThrowValidation'
    def get_method() = 'POST'
end

# @Route("/throwbusinesserror")
class ThrowBusinessError
    include ServiceStack::DTO

    def response_type() = ThrowBusinessErrorResponse
    def get_type_name() = 'ThrowBusinessError'
    def get_method() = 'POST'
end

#
# Convert speech to text
#
# @Api(Description: "Convert speech to text")
class SpeechToText
    include ServiceStack::DTO

    # @ApiMember(Description: "The audio stream containing the speech to be transcribed")
    # @Required
    # @return [String]
    attr_accessor :audio

    # @ApiMember(Description: "Optional client-provided identifier for the request")
    # @return [String]
    attr_accessor :ref_id

    # @ApiMember(Description: "Tag to identify the request")
    # @return [String]
    attr_accessor :tag

    def self.properties
        {
            audio: { name: 'audio' },
            ref_id: { name: 'refId' },
            tag: { name: 'tag' },
        }
    end

    def response_type() = TextGenerationResponse
    def get_type_name() = 'SpeechToText'
    def get_method() = 'POST'
end

class TestFileUploads
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :ref_id

    def self.properties
        {
            id: { name: 'id' },
            ref_id: { name: 'refId' },
        }
    end

    def response_type() = TestFileUploadsResponse
    def get_type_name() = 'TestFileUploads'
    def get_method() = 'POST'
end

class RootPathRoutes
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :path

    def self.properties
        {
            path: { name: 'path' },
        }
    end

end

class GetAccount
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :account

    def self.properties
        {
            account: { name: 'account' },
        }
    end

    def response_type() = Account
    def get_type_name() = 'GetAccount'
    def get_method() = 'POST'
end

class GetProject
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :account
    # @return [String]
    attr_accessor :project

    def self.properties
        {
            account: { name: 'account' },
            project: { name: 'project' },
        }
    end

    def response_type() = Project
    def get_type_name() = 'GetProject'
    def get_method() = 'POST'
end

# @Route("/image-stream")
class ImageAsStream
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :format

    def self.properties
        {
            format: { name: 'format' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ImageAsStream'
    def get_method() = 'POST'
end

# @Route("/image-bytes")
class ImageAsBytes
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :format

    def self.properties
        {
            format: { name: 'format' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ImageAsBytes'
    def get_method() = 'POST'
end

# @Route("/image-custom")
class ImageAsCustomResult
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :format

    def self.properties
        {
            format: { name: 'format' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ImageAsCustomResult'
    def get_method() = 'POST'
end

# @Route("/image-response")
class ImageWriteToResponse
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :format

    def self.properties
        {
            format: { name: 'format' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ImageWriteToResponse'
    def get_method() = 'POST'
end

# @Route("/image-file")
class ImageAsFile
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :format

    def self.properties
        {
            format: { name: 'format' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ImageAsFile'
    def get_method() = 'POST'
end

# @Route("/image-redirect")
class ImageAsRedirect
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :format

    def self.properties
        {
            format: { name: 'format' },
        }
    end

end

# @Route("/hello-image/{Name}")
class HelloImage
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :format
    # @return [Integer]
    attr_accessor :width
    # @return [Integer]
    attr_accessor :height
    # @return [Integer]
    attr_accessor :font_size
    # @return [String]
    attr_accessor :font_family
    # @return [String]
    attr_accessor :foreground
    # @return [String]
    attr_accessor :background

    def self.properties
        {
            name: { name: 'name' },
            format: { name: 'format' },
            width: { name: 'width' },
            height: { name: 'height' },
            font_size: { name: 'fontSize' },
            font_family: { name: 'fontFamily' },
            foreground: { name: 'foreground' },
            background: { name: 'background' },
        }
    end

    def response_type() = String
    def get_type_name() = 'HelloImage'
    def get_method() = 'GET'
end

# @Route("/secured")
# @ValidateRequest(Validator: "IsAuthenticated")
class Secured
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = SecuredResponse
    def get_type_name() = 'Secured'
    def get_method() = 'POST'
end

# @Route("/jwt")
class CreateJwt < AuthUserSession
    # @return [DateTime]
    attr_accessor :jwt_expiry

    def self.properties
        {
            jwt_expiry: { name: 'jwtExpiry', type: DateTime },
        }
    end

    def response_type() = CreateJwtResponse
    def get_type_name() = 'CreateJwt'
    def get_method() = 'POST'
end

# @Route("/jwt-refresh")
class CreateRefreshJwt
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :user_auth_id
    # @return [DateTime]
    attr_accessor :jwt_expiry

    def self.properties
        {
            user_auth_id: { name: 'userAuthId' },
            jwt_expiry: { name: 'jwtExpiry', type: DateTime },
        }
    end

    def response_type() = CreateRefreshJwtResponse
    def get_type_name() = 'CreateRefreshJwt'
    def get_method() = 'POST'
end

# @Route("/jwt-invalidate")
class InvalidateLastAccessToken
    include ServiceStack::DTO

    def response_type() = ServiceStack::EmptyResponse
    def get_type_name() = 'InvalidateLastAccessToken'
    def get_method() = 'POST'
end

# @Route("/logs")
class ViewLogs
    include ServiceStack::DTO

    # @return [TrueClass]
    attr_accessor :clear

    def self.properties
        {
            clear: { name: 'clear' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ViewLogs'
    def get_method() = 'POST'
end

# @Route("/metadatatest")
class MetadataTest
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = MetadataTestResponse
    def get_type_name() = 'MetadataTest'
    def get_method() = 'POST'
end

# @Route("/metadatatest-array")
class MetadataTestArray
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = Array
    def get_type_name() = 'MetadataTestArray'
    def get_method() = 'POST'
end

# @Route("/example", "GET")
# @DataContract
class GetExample
    include ServiceStack::DTO

    def response_type() = GetExampleResponse
    def get_type_name() = 'GetExample'
    def get_method() = 'GET'
end

# @Route("/messages/{Id}", "GET")
class RequestMessage
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = Message
    def get_type_name() = 'RequestMessage'
    def get_method() = 'GET'
end

# @Route("/randomids")
class GetRandomIds
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :take

    def self.properties
        {
            take: { name: 'take' },
        }
    end

    def response_type() = GetRandomIdsResponse
    def get_type_name() = 'GetRandomIds'
    def get_method() = 'POST'
end

# @Route("/textfile-test")
class TextFileTest
    include ServiceStack::DTO

    # @return [TrueClass]
    attr_accessor :as_attachment

    def self.properties
        {
            as_attachment: { name: 'asAttachment' },
        }
    end

end

# @Route("/return/text")
class ReturnText
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :text

    def self.properties
        {
            text: { name: 'text' },
        }
    end

end

# @Route("/return/html")
class ReturnHtml
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :text

    def self.properties
        {
            text: { name: 'text' },
        }
    end

end

# @Route("/hello")
class Hello
    include ServiceStack::DTO

    # @Required
    # @return [String]
    attr_accessor :name

    # @return [String]
    attr_accessor :title

    def self.properties
        {
            name: { name: 'name' },
            title: { name: 'title' },
        }
    end

    def response_type() = HelloResponse
    def get_type_name() = 'Hello'
    def get_method() = 'POST'
end

# @Route("/hello-secure/{Name}")
# @ValidateRequest(Validator: "IsAuthenticated")
class HelloSecure
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = HelloResponse
    def get_type_name() = 'HelloSecure'
    def get_method() = 'POST'
end

class HelloWithNestedClass
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [NestedClass]
    attr_accessor :nested_class_prop

    def self.properties
        {
            name: { name: 'name' },
            nested_class_prop: { name: 'nestedClassProp', type: NestedClass },
        }
    end

    def response_type() = HelloResponse
    def get_type_name() = 'HelloWithNestedClass'
    def get_method() = 'GET'
end

class HelloList
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :names

    def self.properties
        {
            names: { name: 'names' },
        }
    end

    def response_type() = List
    def get_type_name() = 'HelloList'
    def get_method() = 'POST'
end

class HelloArray
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :names

    def self.properties
        {
            names: { name: 'names' },
        }
    end

    def response_type() = Array
    def get_type_name() = 'HelloArray'
    def get_method() = 'POST'
end

class HelloMap
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :names

    def self.properties
        {
            names: { name: 'names' },
        }
    end

    def response_type() = Dictionary
    def get_type_name() = 'HelloMap'
    def get_method() = 'POST'
end

class HelloQueryResponse
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :names

    def self.properties
        {
            names: { name: 'names' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(String)
    def get_type_name() = 'HelloQueryResponse'
    def get_method() = 'POST'
end

class HelloWithEnum
    include ServiceStack::DTO

    # @return [EnumType]
    attr_accessor :enum_prop
    # @return [EnumTypeFlags]
    attr_accessor :enum_type_flags
    # @return [EnumWithValues]
    attr_accessor :enum_with_values
    # @return [EnumType]
    attr_accessor :nullable_enum_prop
    # @return [EnumFlags]
    attr_accessor :enum_flags
    # @return [EnumAsInt]
    attr_accessor :enum_as_int
    # @return [EnumStyle]
    attr_accessor :enum_style
    # @return [EnumStyleMembers]
    attr_accessor :enum_style_members

    def self.properties
        {
            enum_prop: { name: 'enumProp' },
            enum_type_flags: { name: 'enumTypeFlags' },
            enum_with_values: { name: 'enumWithValues' },
            nullable_enum_prop: { name: 'nullableEnumProp' },
            enum_flags: { name: 'enumFlags' },
            enum_as_int: { name: 'enumAsInt' },
            enum_style: { name: 'enumStyle' },
            enum_style_members: { name: 'enumStyleMembers' },
        }
    end

end

class HelloWithEnumList
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :enum_prop
    # @return [List]
    attr_accessor :enum_with_values
    # @return [List]
    attr_accessor :nullable_enum_prop
    # @return [List]
    attr_accessor :enum_flags
    # @return [List]
    attr_accessor :enum_style

    def self.properties
        {
            enum_prop: { name: 'enumProp' },
            enum_with_values: { name: 'enumWithValues' },
            nullable_enum_prop: { name: 'nullableEnumProp' },
            enum_flags: { name: 'enumFlags' },
            enum_style: { name: 'enumStyle' },
        }
    end

end

class HelloWithEnumMap
    include ServiceStack::DTO

    # @return [Dictionary]
    attr_accessor :enum_prop
    # @return [Dictionary]
    attr_accessor :enum_with_values
    # @return [Dictionary]
    attr_accessor :nullable_enum_prop
    # @return [Dictionary]
    attr_accessor :enum_flags
    # @return [Dictionary]
    attr_accessor :enum_style

    def self.properties
        {
            enum_prop: { name: 'enumProp' },
            enum_with_values: { name: 'enumWithValues' },
            nullable_enum_prop: { name: 'nullableEnumProp' },
            enum_flags: { name: 'enumFlags' },
            enum_style: { name: 'enumStyle' },
        }
    end

end

class HelloExternal
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

end

#
# AllowedAttributes Description
#
# @Route("/allowed-attributes", "GET")
# @Api(Description: "AllowedAttributes Description")
# @ApiResponse(Description: "Your request was not understood", StatusCode: 400)
# @DataContract
class AllowedAttributes
    include ServiceStack::DTO

    # @DataMember(Name="Aliased")
    # @ApiMember(DataType: "double", Description: "Range Description", IsRequired: "true", ParameterType: "path")
    # @return [Float]
    attr_accessor :range

    def self.properties
        {
            range: { name: 'Aliased' },
        }
    end

end

# @Route("/all-types")
class HelloAllTypes
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [AllTypes]
    attr_accessor :all_types
    # @return [AllCollectionTypes]
    attr_accessor :all_collection_types

    def self.properties
        {
            name: { name: 'name' },
            all_types: { name: 'allTypes', type: AllTypes },
            all_collection_types: { name: 'allCollectionTypes', type: AllCollectionTypes },
        }
    end

    def response_type() = HelloAllTypesResponse
    def get_type_name() = 'HelloAllTypes'
    def get_method() = 'POST'
end

class HelloSubAllTypes < AllTypesBase
    # @return [Integer]
    attr_accessor :hierarchy

    def self.properties
        {
            hierarchy: { name: 'hierarchy' },
        }
    end

    def response_type() = SubAllTypes
    def get_type_name() = 'HelloSubAllTypes'
    def get_method() = 'POST'
end

class HelloString
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = String
    def get_type_name() = 'HelloString'
    def get_method() = 'POST'
end

class HelloVoid
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

end

# @DataContract
class HelloWithDataContract
    include ServiceStack::DTO

    # @DataMember(Name="name", Order=1, IsRequired=true, EmitDefaultValue=false)
    # @return [String]
    attr_accessor :name

    # @DataMember(Name="id", Order=2, EmitDefaultValue=false)
    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            name: { name: 'name' },
            id: { name: 'id' },
        }
    end

    def response_type() = HelloWithDataContractResponse
    def get_type_name() = 'HelloWithDataContract'
    def get_method() = 'POST'
end

#
# Description on HelloWithDescription type
#
class HelloWithDescription
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = HelloWithDescriptionResponse
    def get_type_name() = 'HelloWithDescription'
    def get_method() = 'POST'
end

class HelloWithInheritance < HelloBase
    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = HelloWithInheritanceResponse
    def get_type_name() = 'HelloWithInheritance'
    def get_method() = 'POST'
end

class HelloWithGenericInheritance < HelloBase_1
    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class HelloWithGenericInheritance2 < HelloBase_1
    # @return [String]
    attr_accessor :result

    def self.properties
        {
            result: { name: 'result' },
        }
    end

end

class HelloWithReturn
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = HelloWithAlternateReturnResponse
    def get_type_name() = 'HelloWithReturn'
    def get_method() = 'POST'
end

# @Route("/helloroute")
class HelloWithRoute
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = HelloWithRouteResponse
    def get_type_name() = 'HelloWithRoute'
    def get_method() = 'POST'
end

class HelloWithType
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = HelloWithTypeResponse
    def get_type_name() = 'HelloWithType'
    def get_method() = 'POST'
end

class HelloInterface
    include ServiceStack::DTO

    # @return [IPoco]
    attr_accessor :poco
    # @return [IEmptyInterface]
    attr_accessor :empty_interface
    # @return [EmptyClass]
    attr_accessor :empty_class

    def self.properties
        {
            poco: { name: 'poco', type: IPoco },
            empty_interface: { name: 'emptyInterface', type: IEmptyInterface },
            empty_class: { name: 'emptyClass', type: EmptyClass },
        }
    end

end

class HelloInnerTypes
    include ServiceStack::DTO

    def response_type() = HelloInnerTypesResponse
    def get_type_name() = 'HelloInnerTypes'
    def get_method() = 'POST'
end

class HelloBuiltin
    include ServiceStack::DTO

    # @return [DayOfWeek]
    attr_accessor :day_of_week

    def self.properties
        {
            day_of_week: { name: 'dayOfWeek' },
        }
    end

end

class HelloGet
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = HelloVerbResponse
    def get_type_name() = 'HelloGet'
    def get_method() = 'GET'
end

class HelloPost < HelloBase
    def response_type() = HelloVerbResponse
    def get_type_name() = 'HelloPost'
    def get_method() = 'POST'
end

class HelloPut
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = HelloVerbResponse
    def get_type_name() = 'HelloPut'
    def get_method() = 'PUT'
end

class HelloDelete
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = HelloVerbResponse
    def get_type_name() = 'HelloDelete'
    def get_method() = 'DELETE'
end

class HelloPatch
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = HelloVerbResponse
    def get_type_name() = 'HelloPatch'
    def get_method() = 'PATCH'
end

class HelloReturnVoid
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = nil
    def get_type_name() = 'HelloReturnVoid'
    def get_method() = 'POST'
end

class EnumRequest
    include ServiceStack::DTO

    # @return [ScopeType]
    attr_accessor :operator

    def self.properties
        {
            operator: { name: 'operator' },
        }
    end

    def response_type() = EnumResponse
    def get_type_name() = 'EnumRequest'
    def get_method() = 'PUT'
end

# @Route("/hellozip")
# @DataContract
class HelloZip
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name
    # @return [List]
    attr_accessor :test

    def self.properties
        {
            name: { name: 'name' },
            test: { name: 'test' },
        }
    end

    def response_type() = HelloZipResponse
    def get_type_name() = 'HelloZip'
    def get_method() = 'POST'
end

# @Route("/ping")
class Ping
    include ServiceStack::DTO

    def response_type() = PingResponse
    def get_type_name() = 'Ping'
    def get_method() = 'POST'
end

# @Route("/reset-connections")
class ResetConnections
    include ServiceStack::DTO

end

# @Route("/requires-role")
class RequiresRole
    include ServiceStack::DTO

    def response_type() = RequiresRoleResponse
    def get_type_name() = 'RequiresRole'
    def get_method() = 'POST'
end

# @Route("/return/string")
class ReturnString
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :data

    def self.properties
        {
            data: { name: 'data' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ReturnString'
    def get_method() = 'POST'
end

# @Route("/return/bytes")
class ReturnBytes
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :data

    def self.properties
        {
            data: { name: 'data' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ReturnBytes'
    def get_method() = 'POST'
end

# @Route("/return/stream")
class ReturnStream
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :data

    def self.properties
        {
            data: { name: 'data' },
        }
    end

    def response_type() = String
    def get_type_name() = 'ReturnStream'
    def get_method() = 'POST'
end

# @Route("/return/json")
class ReturnJson
    include ServiceStack::DTO

end

# @Route("/return/json/header")
class ReturnJsonHeader
    include ServiceStack::DTO

end

# @Route("/write/json")
class WriteJson
    include ServiceStack::DTO

end

# @Route("/Request1", "GET")
class GetRequest1
    include ServiceStack::DTO

    def response_type() = List
    def get_type_name() = 'GetRequest1'
    def get_method() = 'GET'
end

# @Route("/Request2", "GET")
class GetRequest2
    include ServiceStack::DTO

    def response_type() = List
    def get_type_name() = 'GetRequest2'
    def get_method() = 'GET'
end

# @Route("/sendjson")
class SendJson
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :request_stream

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
            request_stream: { name: 'requestStream' },
        }
    end

    def response_type() = String
    def get_type_name() = 'SendJson'
    def get_method() = 'POST'
end

# @Route("/sendtext")
class SendText
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :content_type
    # @return [String]
    attr_accessor :request_stream

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
            content_type: { name: 'contentType' },
            request_stream: { name: 'requestStream' },
        }
    end

    def response_type() = String
    def get_type_name() = 'SendText'
    def get_method() = 'POST'
end

# @Route("/sendraw")
class SendRaw
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :content_type
    # @return [String]
    attr_accessor :request_stream

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
            content_type: { name: 'contentType' },
            request_stream: { name: 'requestStream' },
        }
    end

    def response_type() = String
    def get_type_name() = 'SendRaw'
    def get_method() = 'POST'
end

class SendDefault
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = SendVerbResponse
    def get_type_name() = 'SendDefault'
    def get_method() = 'POST'
end

# @Route("/sendrestget/{Id}", "GET")
class SendRestGet
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = SendVerbResponse
    def get_type_name() = 'SendRestGet'
    def get_method() = 'GET'
end

class SendGet
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = SendVerbResponse
    def get_type_name() = 'SendGet'
    def get_method() = 'GET'
end

class SendPost
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = SendVerbResponse
    def get_type_name() = 'SendPost'
    def get_method() = 'POST'
end

class SendPut
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = SendVerbResponse
    def get_type_name() = 'SendPut'
    def get_method() = 'PUT'
end

class SendReturnVoid
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = nil
    def get_type_name() = 'SendReturnVoid'
    def get_method() = 'POST'
end

# @Route("/session")
class GetSession
    include ServiceStack::DTO

    def response_type() = GetSessionResponse
    def get_type_name() = 'GetSession'
    def get_method() = 'POST'
end

# @Route("/session/edit/{CustomName}")
class UpdateSession
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :custom_name

    def self.properties
        {
            custom_name: { name: 'customName' },
        }
    end

    def response_type() = GetSessionResponse
    def get_type_name() = 'UpdateSession'
    def get_method() = 'POST'
end

# @Route("/Stuff")
# @DataContract(Namespace="http://schemas.servicestack.net/types")
class GetStuff
    include ServiceStack::DTO

    # @ApiMember(DataType: "DateTime", Name: "Summary Date")
    # @return [DateTime]
    attr_accessor :summary_date

    # @ApiMember(DataType: "DateTime", Name: "Summary End Date")
    # @return [DateTime]
    attr_accessor :summary_end_date

    # @ApiMember(DataType: "string", Name: "Symbol")
    # @return [String]
    attr_accessor :symbol

    # @ApiMember(DataType: "string", Name: "Email")
    # @return [String]
    attr_accessor :email

    # @ApiMember(DataType: "bool", Name: "Is Enabled")
    # @return [TrueClass]
    attr_accessor :is_enabled

    def self.properties
        {
            summary_date: { name: 'summaryDate', type: DateTime },
            summary_end_date: { name: 'summaryEndDate', type: DateTime },
            symbol: { name: 'symbol' },
            email: { name: 'email' },
            is_enabled: { name: 'isEnabled' },
        }
    end

    def response_type() = GetStuffResponse
    def get_type_name() = 'GetStuff'
    def get_method() = 'POST'
end

class StoreLogs
    include ServiceStack::DTO

    # @return [List]
    attr_accessor :loggers

    def self.properties
        {
            loggers: { name: 'loggers', type: [Logger] },
        }
    end

    def response_type() = StoreLogsResponse
    def get_type_name() = 'StoreLogs'
    def get_method() = 'POST'
end

class HelloAuth
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :name

    def self.properties
        {
            name: { name: 'name' },
        }
    end

    def response_type() = HelloResponse
    def get_type_name() = 'HelloAuth'
    def get_method() = 'POST'
end

# @Route("/testauth")
class TestAuth
    include ServiceStack::DTO

    def response_type() = TestAuthResponse
    def get_type_name() = 'TestAuth'
    def get_method() = 'POST'
end

# @Route("/testdata/AllTypes")
class TestDataAllTypes
    include ServiceStack::DTO

    def response_type() = AllTypes
    def get_type_name() = 'TestDataAllTypes'
    def get_method() = 'POST'
end

# @Route("/testdata/AllCollectionTypes")
class TestDataAllCollectionTypes
    include ServiceStack::DTO

    def response_type() = AllCollectionTypes
    def get_type_name() = 'TestDataAllCollectionTypes'
    def get_method() = 'POST'
end

# @Route("/void-response")
class TestVoidResponse
    include ServiceStack::DTO

end

# @Route("/null-response")
class TestNullResponse
    include ServiceStack::DTO

end

# @Route("/assignroles", "POST")
# @DataContract
class AssignRoles
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :user_name

    # @DataMember(Order=2)
    # @return [List]
    attr_accessor :permissions

    # @DataMember(Order=3)
    # @return [List]
    attr_accessor :roles

    # @DataMember(Order=4)
    # @return [Dictionary]
    attr_accessor :meta

    def self.properties
        {
            user_name: { name: 'userName' },
            permissions: { name: 'permissions' },
            roles: { name: 'roles' },
            meta: { name: 'meta' },
        }
    end

    def response_type() = AssignRolesResponse
    def get_type_name() = 'AssignRoles'
    def get_method() = 'POST'
end

# @Route("/unassignroles", "POST")
# @DataContract
class UnAssignRoles
    include ServiceStack::DTO

    # @DataMember(Order=1)
    # @return [String]
    attr_accessor :user_name

    # @DataMember(Order=2)
    # @return [List]
    attr_accessor :permissions

    # @DataMember(Order=3)
    # @return [List]
    attr_accessor :roles

    # @DataMember(Order=4)
    # @return [Dictionary]
    attr_accessor :meta

    def self.properties
        {
            user_name: { name: 'userName' },
            permissions: { name: 'permissions' },
            roles: { name: 'roles' },
            meta: { name: 'meta' },
        }
    end

    def response_type() = UnAssignRolesResponse
    def get_type_name() = 'UnAssignRoles'
    def get_method() = 'POST'
end

#
# Chat Completions API (OpenAI-Compatible)
#
# @Route("/v1/chat/completions", "POST")
# @DataContract
class ChatCompletion
    include ServiceStack::DTO

    # @DataMember(Name="messages")
    # @return [List]
    attr_accessor :messages

    # @DataMember(Name="model")
    # @return [String]
    attr_accessor :model

    # @DataMember(Name="audio")
    # @return [AiChatAudio]
    attr_accessor :audio

    # @DataMember(Name="logit_bias")
    # @return [Dictionary]
    attr_accessor :logit_bias

    # @DataMember(Name="metadata")
    # @return [Dictionary]
    attr_accessor :metadata

    # @DataMember(Name="reasoning_effort")
    # @return [String]
    attr_accessor :reasoning_effort

    # @DataMember(Name="response_format")
    # @return [AiResponseFormat]
    attr_accessor :response_format

    # @DataMember(Name="service_tier")
    # @return [String]
    attr_accessor :service_tier

    # @DataMember(Name="safety_identifier")
    # @return [String]
    attr_accessor :safety_identifier

    # @DataMember(Name="stop")
    # @return [List]
    attr_accessor :stop

    # @DataMember(Name="modalities")
    # @return [List]
    attr_accessor :modalities

    # @DataMember(Name="prompt_cache_key")
    # @return [String]
    attr_accessor :prompt_cache_key

    # @DataMember(Name="tools")
    # @return [List]
    attr_accessor :tools

    # @DataMember(Name="verbosity")
    # @return [String]
    attr_accessor :verbosity

    # @DataMember(Name="temperature")
    # @return [Float]
    attr_accessor :temperature

    # @DataMember(Name="max_completion_tokens")
    # @return [Integer]
    attr_accessor :max_completion_tokens

    # @DataMember(Name="top_logprobs")
    # @return [Integer]
    attr_accessor :top_logprobs

    # @DataMember(Name="top_p")
    # @return [Float]
    attr_accessor :top_p

    # @DataMember(Name="frequency_penalty")
    # @return [Float]
    attr_accessor :frequency_penalty

    # @DataMember(Name="presence_penalty")
    # @return [Float]
    attr_accessor :presence_penalty

    # @DataMember(Name="seed")
    # @return [Integer]
    attr_accessor :seed

    # @DataMember(Name="n")
    # @return [Integer]
    attr_accessor :n

    # @DataMember(Name="store")
    # @return [TrueClass]
    attr_accessor :store

    # @DataMember(Name="logprobs")
    # @return [TrueClass]
    attr_accessor :logprobs

    # @DataMember(Name="parallel_tool_calls")
    # @return [TrueClass]
    attr_accessor :parallel_tool_calls

    # @DataMember(Name="enable_thinking")
    # @return [TrueClass]
    attr_accessor :enable_thinking

    # @DataMember(Name="stream")
    # @return [TrueClass]
    attr_accessor :stream

    def self.properties
        {
            messages: { name: 'messages', type: [AiMessage] },
            model: { name: 'model' },
            audio: { name: 'audio', type: AiChatAudio },
            logit_bias: { name: 'logit_bias' },
            metadata: { name: 'metadata' },
            reasoning_effort: { name: 'reasoning_effort' },
            response_format: { name: 'response_format', type: AiResponseFormat },
            service_tier: { name: 'service_tier' },
            safety_identifier: { name: 'safety_identifier' },
            stop: { name: 'stop' },
            modalities: { name: 'modalities' },
            prompt_cache_key: { name: 'prompt_cache_key' },
            tools: { name: 'tools', type: [Tool] },
            verbosity: { name: 'verbosity' },
            temperature: { name: 'temperature' },
            max_completion_tokens: { name: 'max_completion_tokens' },
            top_logprobs: { name: 'top_logprobs' },
            top_p: { name: 'top_p' },
            frequency_penalty: { name: 'frequency_penalty' },
            presence_penalty: { name: 'presence_penalty' },
            seed: { name: 'seed' },
            n: { name: 'n' },
            store: { name: 'store' },
            logprobs: { name: 'logprobs' },
            parallel_tool_calls: { name: 'parallel_tool_calls' },
            enable_thinking: { name: 'enable_thinking' },
            stream: { name: 'stream' },
        }
    end

    def response_type() = ChatResponse
    def get_type_name() = 'ChatCompletion'
    def get_method() = 'POST'
end

#
# Find Bookings
#
# @Route("/bookings", "GET")
class QueryBookings < ServiceStack::QueryDb
    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(Booking)
    def get_type_name() = 'QueryBookings'
    def get_method() = 'GET'
end

#
# Find Coupons
#
# @Route("/coupons", "GET")
class QueryCoupons < ServiceStack::QueryDb
    # @return [String]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(Coupon)
    def get_type_name() = 'QueryCoupons'
    def get_method() = 'GET'
end

class QueryAddresses < ServiceStack::QueryDb
    # @return [Array]
    attr_accessor :ids

    def self.properties
        {
            ids: { name: 'ids' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(Address)
    def get_type_name() = 'QueryAddresses'
    def get_method() = 'GET'
end

class QueryRockstarAudit < QueryDbTenant
    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(RockstarAuto)
    def get_type_name() = 'QueryRockstarAudit'
    def get_method() = 'GET'
end

class QueryRockstarAuditSubOr < ServiceStack::QueryDb
    # @return [String]
    attr_accessor :first_name_starts_with
    # @return [Integer]
    attr_accessor :age_older_than

    def self.properties
        {
            first_name_starts_with: { name: 'firstNameStartsWith' },
            age_older_than: { name: 'ageOlderThan' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(RockstarAuto)
    def get_type_name() = 'QueryRockstarAuditSubOr'
    def get_method() = 'GET'
end

class QueryPocoBase < ServiceStack::QueryDb
    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(OnlyDefinedInGenericType)
    def get_type_name() = 'QueryPocoBase'
    def get_method() = 'GET'
end

class QueryPocoIntoBase < ServiceStack::QueryDb
    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(OnlyDefinedInGenericTypeInto)
    def get_type_name() = 'QueryPocoIntoBase'
    def get_method() = 'GET'
end

# @Route("/message/query/{Id}", "GET")
class MessageQuery < ServiceStack::QueryDb
    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = ServiceStack::QueryResponse.of(MessageQuery)
    def get_type_name() = 'MessageQuery'
    def get_method() = 'GET'
end

# @Route("/rockstars", "GET")
class QueryRockstars < ServiceStack::QueryDb
    def response_type() = ServiceStack::QueryResponse.of(Rockstar)
    def get_type_name() = 'QueryRockstars'
    def get_method() = 'GET'
end

#
# Create a new Booking
#
# @Route("/bookings", "POST")
# @ValidateRequest(Validator: "HasRole(`Employee`)")
class CreateBooking
    include ServiceStack::DTO

    # @Validate(Validator: "NotEmpty")
    # @return [String]
    attr_accessor :name

    # @return [RoomType]
    attr_accessor :room_type
    # @Validate(Validator: "GreaterThan(0)")
    # @return [Integer]
    attr_accessor :room_number

    # @Validate(Validator: "GreaterThan(0)")
    # @return [BigDecimal]
    attr_accessor :cost

    # @Required
    # @return [DateTime]
    attr_accessor :booking_start_date

    # @return [DateTime]
    attr_accessor :booking_end_date
    # @return [String]
    attr_accessor :notes
    # @return [String]
    attr_accessor :coupon_id
    # @return [Integer]
    attr_accessor :permanent_address_id
    # @return [Integer]
    attr_accessor :postal_address_id

    def self.properties
        {
            name: { name: 'name' },
            room_type: { name: 'roomType' },
            room_number: { name: 'roomNumber' },
            cost: { name: 'cost' },
            booking_start_date: { name: 'bookingStartDate', type: DateTime },
            booking_end_date: { name: 'bookingEndDate', type: DateTime },
            notes: { name: 'notes' },
            coupon_id: { name: 'couponId' },
            permanent_address_id: { name: 'permanentAddressId' },
            postal_address_id: { name: 'postalAddressId' },
        }
    end

    def response_type() = ServiceStack::IdResponse
    def get_type_name() = 'CreateBooking'
    def get_method() = 'POST'
end

#
# Update an existing Booking
#
# @Route("/booking/{Id}", "PATCH")
# @ValidateRequest(Validator: "HasRole(`Employee`)")
class UpdateBooking
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :name
    # @return [RoomType]
    attr_accessor :room_type
    # @Validate(Validator: "GreaterThan(0)")
    # @return [Integer]
    attr_accessor :room_number

    # @Validate(Validator: "GreaterThan(0)")
    # @return [BigDecimal]
    attr_accessor :cost

    # @return [DateTime]
    attr_accessor :booking_start_date
    # @return [DateTime]
    attr_accessor :booking_end_date
    # @return [String]
    attr_accessor :notes
    # @return [String]
    attr_accessor :coupon_id
    # @return [TrueClass]
    attr_accessor :cancelled
    # @return [Integer]
    attr_accessor :permanent_address_id
    # @return [Integer]
    attr_accessor :postal_address_id

    def self.properties
        {
            id: { name: 'id' },
            name: { name: 'name' },
            room_type: { name: 'roomType' },
            room_number: { name: 'roomNumber' },
            cost: { name: 'cost' },
            booking_start_date: { name: 'bookingStartDate', type: DateTime },
            booking_end_date: { name: 'bookingEndDate', type: DateTime },
            notes: { name: 'notes' },
            coupon_id: { name: 'couponId' },
            cancelled: { name: 'cancelled' },
            permanent_address_id: { name: 'permanentAddressId' },
            postal_address_id: { name: 'postalAddressId' },
        }
    end

    def response_type() = ServiceStack::IdResponse
    def get_type_name() = 'UpdateBooking'
    def get_method() = 'PATCH'
end

#
# Delete a Booking
#
# @Route("/booking/{Id}", "DELETE")
class DeleteBooking
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = nil
    def get_type_name() = 'DeleteBooking'
    def get_method() = 'DELETE'
end

# @Route("/coupons", "POST")
# @ValidateRequest(Validator: "HasRole(`Employee`)")
class CreateCoupon
    include ServiceStack::DTO

    # @Validate(Validator: "NotEmpty")
    # @return [String]
    attr_accessor :id

    # @Validate(Validator: "NotEmpty")
    # @return [String]
    attr_accessor :description

    # @Validate(Validator: "GreaterThan(0)")
    # @return [Integer]
    attr_accessor :discount

    # @Validate(Validator: "NotNull")
    # @return [DateTime]
    attr_accessor :expiry_date

    def self.properties
        {
            id: { name: 'id' },
            description: { name: 'description' },
            discount: { name: 'discount' },
            expiry_date: { name: 'expiryDate', type: DateTime },
        }
    end

    def response_type() = ServiceStack::IdResponse
    def get_type_name() = 'CreateCoupon'
    def get_method() = 'POST'
end

# @Route("/coupons/{Id}", "PATCH")
# @ValidateRequest(Validator: "HasRole(`Employee`)")
class UpdateCoupon
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :id
    # @Validate(Validator: "NotEmpty")
    # @return [String]
    attr_accessor :description

    # @Validate(Validator: "NotNull")
    # @return [Integer]
    attr_accessor :discount

    # @Validate(Validator: "NotNull")
    # @return [DateTime]
    attr_accessor :expiry_date

    def self.properties
        {
            id: { name: 'id' },
            description: { name: 'description' },
            discount: { name: 'discount' },
            expiry_date: { name: 'expiryDate', type: DateTime },
        }
    end

    def response_type() = ServiceStack::IdResponse
    def get_type_name() = 'UpdateCoupon'
    def get_method() = 'PATCH'
end

#
# Delete a Coupon
#
# @Route("/coupons/{Id}", "DELETE")
# @ValidateRequest(Validator: "HasRole(`Manager`)")
class DeleteCoupon
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = nil
    def get_type_name() = 'DeleteCoupon'
    def get_method() = 'DELETE'
end

class CreateAddress
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :address_text

    def self.properties
        {
            address_text: { name: 'addressText' },
        }
    end

    def response_type() = ServiceStack::IdResponse
    def get_type_name() = 'CreateAddress'
    def get_method() = 'POST'
end

class UpdateAddress
    include ServiceStack::DTO

    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :address_text

    def self.properties
        {
            id: { name: 'id' },
            address_text: { name: 'addressText' },
        }
    end

    def response_type() = ServiceStack::IdResponse
    def get_type_name() = 'UpdateAddress'
    def get_method() = 'PATCH'
end

class CreateRockstarAudit < RockstarBase
    def response_type() = RockstarWithIdResponse
    def get_type_name() = 'CreateRockstarAudit'
    def get_method() = 'POST'
end

class CreateRockstarAuditTenant < CreateAuditTenantBase
    # @return [String]
    attr_accessor :session_id
    # @return [String]
    attr_accessor :first_name
    # @return [String]
    attr_accessor :last_name
    # @return [Integer]
    attr_accessor :age
    # @return [DateTime]
    attr_accessor :date_of_birth
    # @return [DateTime]
    attr_accessor :date_died
    # @return [LivingStatus]
    attr_accessor :living_status

    def self.properties
        {
            session_id: { name: 'sessionId' },
            first_name: { name: 'firstName' },
            last_name: { name: 'lastName' },
            age: { name: 'age' },
            date_of_birth: { name: 'dateOfBirth', type: DateTime },
            date_died: { name: 'dateDied', type: DateTime },
            living_status: { name: 'livingStatus' },
        }
    end

    def response_type() = RockstarWithIdAndResultResponse
    def get_type_name() = 'CreateRockstarAuditTenant'
    def get_method() = 'POST'
end

class UpdateRockstarAuditTenant < UpdateAuditTenantBase
    # @return [String]
    attr_accessor :session_id
    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :first_name
    # @return [LivingStatus]
    attr_accessor :living_status

    def self.properties
        {
            session_id: { name: 'sessionId' },
            id: { name: 'id' },
            first_name: { name: 'firstName' },
            living_status: { name: 'livingStatus' },
        }
    end

    def response_type() = RockstarWithIdAndResultResponse
    def get_type_name() = 'UpdateRockstarAuditTenant'
    def get_method() = 'PUT'
end

class PatchRockstarAuditTenant < PatchAuditTenantBase
    # @return [String]
    attr_accessor :session_id
    # @return [Integer]
    attr_accessor :id
    # @return [String]
    attr_accessor :first_name
    # @return [LivingStatus]
    attr_accessor :living_status

    def self.properties
        {
            session_id: { name: 'sessionId' },
            id: { name: 'id' },
            first_name: { name: 'firstName' },
            living_status: { name: 'livingStatus' },
        }
    end

    def response_type() = RockstarWithIdAndResultResponse
    def get_type_name() = 'PatchRockstarAuditTenant'
    def get_method() = 'PATCH'
end

class SoftDeleteAuditTenant < SoftDeleteAuditTenantBase
    # @return [Integer]
    attr_accessor :id

    def self.properties
        {
            id: { name: 'id' },
        }
    end

    def response_type() = RockstarWithIdAndResultResponse
    def get_type_name() = 'SoftDeleteAuditTenant'
    def get_method() = 'PUT'
end

class CreateRockstarAuditMqToken < RockstarBase
    # @return [String]
    attr_accessor :bearer_token

    def self.properties
        {
            bearer_token: { name: 'bearerToken' },
        }
    end

    def response_type() = RockstarWithIdResponse
    def get_type_name() = 'CreateRockstarAuditMqToken'
    def get_method() = 'POST'
end

class RealDeleteAuditTenant
    include ServiceStack::DTO

    # @return [String]
    attr_accessor :session_id
    # @return [Integer]
    attr_accessor :id
    # @return [Integer]
    attr_accessor :age

    def self.properties
        {
            session_id: { name: 'sessionId' },
            id: { name: 'id' },
            age: { name: 'age' },
        }
    end

    def response_type() = RockstarWithIdAndCountResponse
    def get_type_name() = 'RealDeleteAuditTenant'
    def get_method() = 'DELETE'
end

class CreateRockstarVersion < RockstarBase
    def response_type() = RockstarWithIdAndRowVersionResponse
    def get_type_name() = 'CreateRockstarVersion'
    def get_method() = 'POST'
end
