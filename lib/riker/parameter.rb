# frozen_string_literal: true

module Riker
  # Single Command Parameter
  #
  class Parameter
    # @return [Symbol]
    attr_reader :name

    # @param name [Symbol]
    # @param required [Boolean]
    def initialize(name, required: true)
      @name = name
      @required = required
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
      return if required?

      'nil'
    end
  end
end
