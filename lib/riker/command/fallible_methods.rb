# frozen_string_literal: true

module Riker
  class Command
    # Fallible Methods
    #
    # Every command has fallible functionality.  This is
    # how you can convey something has gone wrong to the
    # caller of your command.
    #
    module FallibleMethods
      # @return [Riker::Outcome::Errors]
      def errors
        @errors ||= Riker::Outcome::Errors.new
      end

      # @return [Boolean]
      def errored?
        defined?(@errors) && @errors.any?
      end
    end
  end
end
