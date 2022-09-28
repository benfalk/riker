# frozen_string_literal: true

require_relative 'parameter/default_value'

module Riker
  # Single Command Parameter
  #
  class Parameter
    # @return [Symbol]
    attr_reader :name

    # @return [DefaultValue]
    attr_reader :default

    # @param name [Symbol]
    # @param required [Boolean]
    # @param default [Object, Proc]
    def initialize(
      name,
      required: true,
      default: DefaultValue.no_value
    )
      @name = name
      @required = required
      @default = DefaultValue.new(name, default)
    end

    # @return [Boolean]
    def required?
      @required
    end

    # @return [String]
    def ctor_arg
      @ctor_arg ||= "#{name}: #{fallback_default}"
    end

    # @return [String]
    def variable_set
      @variable_set ||= "@#{name} = #{name}"
    end

    private

    def fallback_default
      return default.function_name if default.present?
      return if required?

      'nil'
    end
  end
end
