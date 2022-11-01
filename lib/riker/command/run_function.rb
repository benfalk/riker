# frozen_string_literal: true

module Riker
  class Command
    # Run!
    #
    # Represents the `run!` static method for your command
    #
    class RunFunction < Function
      # @return [Symbol]
      def name
        :run
      end

      # @return [Riker::Command::FunctionDetails]
      def details
        if command.around_block
          with_around_block_function
        else
          without_around_block_function
        end
      end

      private

      def without_around_block_function
        FunctionDetails.new(<<~RUBY, __FILE__, __LINE__ + 1)
          def self.run(**arguments)                   # def self.run!(**arguments)
            command = new(**arguments)                #   command = new(**arguments)
            result = command.execute                  #   result = command.execute
            if command.errored?                       #   if command.errored?
              Riker::Outcome.invalid(command.errors)  #     Riker::Outcome.invalid(command.errors)
            else                                      #   else
              Riker::Outcome.valid(result)            #     Riker::Outcome.valid(result)
            end                                       #   end
          end                                         # end
        RUBY
      end

      def with_around_block_function
        FunctionDetails.new(<<~RUBY, __FILE__, __LINE__ + 1)
          def self.run(**arguments)                             # def self.run!(**arguments)
            outcome = nil                                       #   outcome = nil
            self.command.around_block.call(self, arguments) do  #   self.command.around_block.call(self, arguments) do
              command = new(**arguments)                        #     command = new(**arguments)
              result = command.execute                          #     result = command.execute
              outcome = if command.errored?                     #     outcome = if command.errored?
                Riker::Outcome.invalid(command.errors)          #       Riker::Outcome.invalid(command.errors)
              else                                              #     else
                Riker::Outcome.valid(result)                    #       Riker::Outcome.valid(result)
              end                                               #     end
            end                                                 #   end
            outcome                                             #   outcome
          end                                                   # end
        RUBY
      end
    end
  end
end
