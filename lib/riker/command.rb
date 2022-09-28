# frozen_string_literal: true

module Riker
  # Command Builder
  #
  # This is responsible for orchestrating and keeping
  # track of the build of a command in your application
  #
  class Command
    # @return [Riker::CommandParameters]
    attr_reader :parameters

    # @return [Proc, nil]
    attr_accessor :execute_block

    def initialize
      @parameters = CommandParameters.new
    end

    # @param klass [Class]
    def build!(klass)
      klass.define_method(:execute, &execute_block)
      define_default_setters!(klass)
      define_init!(klass)
      define_run_bang!(klass)
      define_attr_readers!(klass)
    end

    private

    # @param klass [Class]
    def define_init!(klass)
      klass.class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
        def initialize(#{parameters.ctor_args})  # def initialize(foo:)
          #{parameters.variable_sets}            #   @foo = foo
        end                                      # end
      RUBY
    end

    # @param klass [Class]
    def define_run_bang!(klass)
      klass.class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
        def self.run!(**arguments)    # def initialize(**arguments)
          command = new(**arguments)  #   command = new(**arguments)
          command.execute             #   command.execute
        end                           # end
      RUBY
    end

    # @param klass [Class]
    def define_attr_readers!(klass)
      klass.attr_reader(*parameters.map(&:name))
    end

    # @param klass [Class]
    def define_default_setters!(klass)
      parameters.each do |param|
        param.default.build_default_function!(klass)
      end
    end
  end
end
