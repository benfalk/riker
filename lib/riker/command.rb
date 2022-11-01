# frozen_string_literal: true

require_relative 'command/parameters'
require_relative 'command/fallible_methods'
require_relative 'command/function'
require_relative 'command/function_details'
require_relative 'command/function_writer'

module Riker
  # Command Builder
  #
  # This is responsible for orchestrating and keeping
  # track of the build of a command in your application
  #
  class Command
    # @return [Riker::Command::Parameters]
    attr_reader :parameters

    # @return [Riker::Command::FunctionWriter]
    attr_reader :function_writer

    # @return [Proc, nil]
    attr_accessor :execute_block

    # @return [Proc, nil]
    attr_accessor :around_block

    def initialize
      @parameters = Parameters.new
      @function_writer = FunctionWriter.new(self)
    end
  end
end
