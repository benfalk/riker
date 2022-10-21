# frozen_string_literal: true

module Riker
  class Outcome
    # Outcome Errors
    #
    # A wrapper to keep track of and report on errors
    # that happened during the execution of a command.
    #
    class Errors
      # @!method any?
      #   @return [Boolean]
      # @!method none?
      #   @return [Boolean]
      extend Forwardable
      def_delegators :@errors, :any?, :none?

      def initialize
        @errors = Hash.new { |hash, key| hash[key] = [] }
      end

      # @param key [Symbol]
      # @param error [String]
      # @return [void]
      def add(key, error)
        @errors[key] << error

        nil
      end

      # @return [Array<String>]
      def messages
        @errors.values.flatten!
      end

      # @raise [Riker::ExecutionError]
      def raise!
        raise as_execution_error
      end

      private

      def as_execution_error
        Riker::Outcome::ExecutionError.new(self)
      end
    end
  end
end
