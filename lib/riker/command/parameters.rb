# frozen_string_literal: true

module Riker
  class Command
    # Command Parameters
    #
    # This is responsible for keeping track of the command's
    # parameters. This includes how they are used and applied
    # to the construction of a command.
    #
    class Parameters
      include Enumerable
      class ParamNameTaken < ::Riker::Error; end
      class InvalidParamName < ::Riker::Error; end
      class ReservedAttributeName < ::Riker::Error; end

      RESERVED_ATTR_NAMES = %i[
        errors
        params
      ].to_set.freeze

      def initialize
        # @var [Hash<Symbol, Parameter>]
        @params = {}
      end

      # @param name [Symbol]
      # @return [Parameters]
      #
      def add(name, **options)
        validate_name!(name)
        @params[name] = Parameter.new(name, **options)

        self
      end

      # @return [String]
      def ctor_args
        map(&:ctor_arg).join(', ')
      end

      # @return [String]
      def variable_sets
        map(&:variable_set).join("\n")
      end

      # @yield [Parameter]
      def each(&block)
        @params.values.each(&block)
      end

      private

      def validate_name!(name)
        raise InvalidParamName unless name.is_a?(Symbol)
        raise ReservedAttributeName if RESERVED_ATTR_NAMES.include?(name)
        raise ParamNameTaken if @params.key?(name)
      end
    end
  end
end
