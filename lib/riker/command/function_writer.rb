# frozen_string_literal: true

require_relative 'run_bang_function'
require_relative 'initialize_function'

module Riker
  class Command
    # Function Writer
    #
    # This is responsible for creating the functions that
    # are needed to create a command pattern class.
    #
    class FunctionWriter
      DEFAULT_FUNCTIONS = [
        RunBangFunction,
        InitializeFunction
      ].freeze

      # @return [Riker::Command]
      attr_reader :command

      # @return [Array<Riker::Command::Function>]
      attr_reader :functions

      # @param command [Riker::Command]
      def initialize(command)
        @command = command
        @functions = DEFAULT_FUNCTIONS.map { |func| func.new(command) }
      end

      # @param klass [Class]
      def write!(klass)
        klass.define_method(:execute, &command.execute_block)
        define_default_setters!(klass)
        define_attr_readers!(klass)
        write_functions!(klass)
      end

      private

      # @param klass [Class]
      def write_functions!(klass)
        functions.each do |function|
          details = function.details
          klass.class_eval(details.code, details.file, details.line)
        end
      end

      # @param klass [Class]
      def define_attr_readers!(klass)
        klass.attr_reader(*command.parameters.map(&:name))
      end

      # @param klass [Class]
      def define_default_setters!(klass)
        command.parameters.each do |param|
          param.default.build_default_function!(klass)
        end
      end
    end
  end
end
