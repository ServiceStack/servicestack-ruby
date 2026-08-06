# frozen_string_literal: true

require 'date'

module ServiceStack
  # Included by generated DTOs to convert them to and from the JSON their APIs
  # are serialized with.
  #
  # Generated DTOs declare the wire name and Type of each property, which is
  # what lets nested DTOs, Dates and collections round-trip correctly:
  #
  #   class Booking
  #     include ServiceStack::DTO
  #     attr_accessor :id, :booking_start_date, :discount
  #
  #     def self.properties
  #       {
  #         id: { name: 'id' },
  #         booking_start_date: { name: 'bookingStartDate', type: DateTime },
  #         discount: { name: 'discount', type: Coupon },
  #       }
  #     end
  #   end
  module DTO
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Creates a DTO, populating any properties passed as keyword args, e.g:
    #
    #   Hello.new(name: 'World')
    def initialize(**kwargs)
      kwargs.each do |key, value|
        setter = "#{key}="
        unless respond_to?(setter)
          raise ArgumentError, "unknown property '#{key}' for #{self.class}"
        end

        public_send(setter, value)
      end
    end

    # The DTO as the Hash it's serialized to, using its wire property names and
    # omitting any properties that aren't populated.
    def to_hash
      to = {}
      self.class.all_properties.each do |attr, meta|
        value = instance_variable_get("@#{attr}")
        next if value.nil?

        to[meta[:name] || attr.to_s] = Serializer.to_json_value(value)
      end
      to
    end
    alias to_h to_hash

    # The DTO as its JSON representation.
    def to_json(*args)
      require 'json'
      to_hash.to_json(*args)
    end

    def ==(other)
      other.is_a?(self.class) && to_hash == other.to_hash
    end

    def inspect
      "#<#{self.class} #{to_hash.map { |k, v| "#{k}=#{v.inspect}" }.join(', ')}>"
    end

    module ClassMethods
      # The wire name and Type of each property, overridden by generated DTOs.
      def properties
        {}
      end

      # This DTO's properties, including the properties it inherits.
      def all_properties
        to = {}
        ancestors.reverse.each do |klass|
          next unless klass.respond_to?(:properties)

          to.merge!(klass.properties)
        end
        to
      end

      # Creates a populated DTO from the Hash of a JSON API Response.
      def from_hash(hash)
        return nil if hash.nil?

        instance = new
        props = all_properties
        hash.each do |key, value|
          attr, meta = find_property(props, key.to_s)
          next if attr.nil?

          instance.instance_variable_set("@#{attr}", Serializer.from_json_value(meta[:type], value))
        end
        instance
      end

      # Creates a populated DTO from a JSON string.
      def from_json(json)
        require 'json'
        from_hash(::JSON.parse(json))
      end

      private

      # Resolves a JSON property to the DTO property it populates, matching on
      # the wire name first, then the DTO's own snake_case name.
      def find_property(props, json_name)
        props.each do |attr, meta|
          return [attr, meta] if meta[:name] == json_name
        end

        snake_name = Serializer.snake_case(json_name).to_sym
        meta = props[snake_name]
        return [snake_name, meta] if meta

        [nil, nil]
      end
    end

    # Converts values to and from their JSON representation.
    module Serializer
      module_function

      def to_json_value(value)
        case value
        when nil then nil
        when ::DateTime, ::Time then value.iso8601
        when ::Date then value.iso8601
        when ::Symbol then value.to_s
        when ::Array then value.map { |x| to_json_value(x) }
        when ::Hash then value.each_with_object({}) { |(k, v), to| to[k.to_s] = to_json_value(v) }
        else
          value.respond_to?(:to_hash) && value.class.include?(DTO) ? value.to_hash : value
        end
      end

      def from_json_value(type, value)
        return nil if value.nil?

        # Arrays declare their element Type, e.g. type: [Booking]
        if type.is_a?(::Array)
          element_type = type.first
          return value.map { |x| from_json_value(element_type, x) } if value.is_a?(::Array)

          return value
        end

        # Hashes declare their key and value Types, e.g. type: { String => Booking }
        if type.is_a?(::Hash)
          value_type = type.values.first
          return value.each_with_object({}) { |(k, v), to| to[k] = from_json_value(value_type, v) } if value.is_a?(::Hash)

          return value
        end

        return value if type.nil?
        return parse_date(value) if type == ::DateTime || type == ::Time || type == ::Date
        return value.to_s if type == ::String
        return value.to_i if type == ::Integer && !value.is_a?(::Integer)
        return value.to_f if type == ::Float && !value.is_a?(::Float)

        if type.is_a?(::Class) && type.include?(DTO) && value.is_a?(::Hash)
          return type.from_hash(value)
        end

        value
      end

      def parse_date(value)
        return value unless value.is_a?(::String)

        # ServiceStack also serializes dates in WCF's /Date(1670000000000)/ format
        if (match = value.match(%r{^/Date\((-?\d+)([+-]\d{4})?\)/$}))
          return ::Time.at(match[1].to_i / 1000.0).to_datetime
        end

        ::DateTime.parse(value)
      rescue ::ArgumentError, ::TypeError
        value
      end

      def snake_case(name)
        name.to_s
            .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .tr('-', '_')
            .downcase
      end

      def camel_case(name)
        parts = name.to_s.split('_')
        ([parts.first] + parts[1..].map(&:capitalize)).join
      end
    end
  end
end
