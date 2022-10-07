# frozen_string_literal: true

module Riker
  class Command
    # Run!
    #
    # Represents the `run!` static method for your command
    #
    class RunBangFunction < Function
      # @return [Symbol]
      def name
        :run!
      end

      # @return [Riker::Command::FunctionDetails]
      def details
        FunctionDetails.new(<<~RUBY, __FILE__, __LINE__ + 1)
          def self.run!(**arguments)    # def initialize(**arguments)
            command = new(**arguments)  #   command = new(**arguments)
            command.execute             #   command.execute
          end                           # end
        RUBY
      end
    end
  end
end
