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
        if command.around_block
          with_around_function_block
        else
          without_around_block_function
        end
      end

      private

      # @return [Riker::Command::FunctionDetails]
      def without_around_block_function
        FunctionDetails.new(<<~RUBY, __FILE__, __LINE__ + 1)
          def self.run!(**arguments)          # def self.run!(**arguments)
            command = new(**arguments)        #   command = new(**arguments)
            result = command.execute          #   result = command.execute
            if command.errored?               #   if command.errored?
              command.errors.raise!           #     command.errors.raise!
            end                               #   end
            result                            #   result
          end                                 # end
        RUBY
      end

      # @return [Riker::Command::FunctionDetails]
      def with_around_function_block
        FunctionDetails.new(<<~RUBY, __FILE__, __LINE__ + 1)
          def self.run!(**arguments)                            # def self.run!(**arguments)
            result = nil                                        #   result = nil
            self.command.around_block.call(self, arguments) do  #   self.command.around_block.call(klass, arguments) do
              command = new(**arguments)                        #     command = new(**arguments)
              result = command.execute                          #     result = command.execute
              if command.errored?                               #     if command.errored?
                command.errors.raise!                           #       command.errors.raise!
              end                                               #     end
            end                                                 #   end
            result                                              #   result
          end                                                   # end
        RUBY
      end
    end
  end
end
