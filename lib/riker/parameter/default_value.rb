# frozen_string_literal: true

module Riker
  class Parameter
    # Default Parameter Value
    #
    # Sometimes we want to have parameters default to sensible
    # defaults.  This class's responsibility is to keep track
    # this and set's up work to ensure defaults setup properly.
    #
    class DefaultValue
      # @return [Symbol]
      attr_reader :name

      # @return [BasicObject]
      def self.no_value
        :__no_default__
      end

      # @param name [Symbol]
      # @param value [Object, Proc]
      def initialize(name, value)
        @name = name
        @present = value != :__no_default__
        @value_proc = value.is_a?(Proc) ? value : -> { value }
      end

      # @return [Boolean]
      def present?
        @present
      end

      # @return [Symbol, nil]
      def function_name
        return unless present?

        @function_name ||= :"default_value_for_#{name}"
      end

      def build_default_function!(klass)
        return unless present?

        klass.define_method(function_name, &@value_proc)
        klass.send(:private, function_name)
      end
    end
  end
end
