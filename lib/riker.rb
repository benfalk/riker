# frozen_string_literal: true

require 'forwardable'
require 'set'

require_relative 'riker/version'
require_relative 'riker/error'
require_relative 'riker/command'
require_relative 'riker/parameter'
require_relative 'riker/outcome'

# The Commander of the USS Enterprise
module Riker
  # @param klass [Class]
  def self.extended(klass)
    klass.instance_variable_set(:@command, Command.new)
  end

  # @return [Riker::Command]
  attr_reader :command

  # @param name [Symbol]
  def param(name, **options)
    command.parameters.add(name, **options)
  end

  # @block the logic of the command
  def execute(&block)
    raise Error, "execute block already called for #{self}!" if command.execute_block

    command.execute_block = block
    command.function_writer.write!(self)
  end

  # @block the logic to run around a command
  def around(&block)
    raise Error, "around block already called for #{self}!" if command.around_block

    command.around_block = block
  end
end
