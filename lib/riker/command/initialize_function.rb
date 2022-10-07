# frozen_string_literal: true

module Riker
  class Command
    # Run!
    #
    # Represents the `initialize` method for your command
    #
    class InitializeFunction < Function
      # @return [Symbol]
      def name
        :initialize
      end

      # @return [Riker::Command::FunctionDetails]
      def details
        FunctionDetails.new(<<~RUBY, __FILE__, __LINE__ + 1)
          def initialize(#{command.parameters.ctor_args})  # def initialize(foo:)
            #{command.parameters.variable_sets}            #   @foo = foo
          end                                              # end
        RUBY
      end
    end
  end
end
