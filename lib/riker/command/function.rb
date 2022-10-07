# frozen_string_literal: true

module Riker
  class Command
    # Individual Function
    #
    # Repsonible for debugging and writing out functions
    # for a command to provide the needed functionality
    # that is setup for it.
    #
    class Function
      # @param command [Riker::Command]
      def initialize(command)
        @command = command
      end

      # @return [Symbol]
      def name
        raise NotImplementedError
      end

      # @return [Riker::Command::FunctionDetails]
      def details
        raise NotImplementedError
      end

      private

      # @return [Riker::Command]
      attr_reader :command
    end
  end
end
