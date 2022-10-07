# frozen_string_literal: true

module Riker
  class Command
    # Function Detail Data
    #
    # Holds information needed to write a function to a class
    # with `class_eval` on a class object.
    #
    class FunctionDetails
      # @return [String]
      attr_reader :code

      # @return [String]
      attr_reader :file

      # @return [Integer]
      attr_reader :line

      def initialize(code, file, line)
        @code = code
        @file = file
        @line = line
      end
    end
  end
end
