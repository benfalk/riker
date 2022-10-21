# frozen_string_literal: true

module Riker
  class Outcome
    # Execution Error
    #
    # This exception is raised when a problem has happened
    # with your command.  It is the result normall of having
    # errors.
    #
    # @see Riker::Command::FallibleMethods
    #
    class ExecutionError < Error
      # @return [Riker::Outcome::Errors]
      attr_reader :errors

      # @param errors [Riker::Outcome::Errors]
      def initialize(errors)
        super()
        @errors = errors
      end
    end
  end
end
