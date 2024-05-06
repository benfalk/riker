# frozen_string_literal: true

module Riker
  class Command
    # Params Method
    #
    # Exposes passes params as a hash.
    #
    module ParamsMethod
      ###
      # Returns a hash representing the params the command is running with.
      # This is helpful when needing to proxy params or for logging.
      # @return [Hash]
      def params
        self.class.command.parameters.each_with_object({}) do |cur, acc|
          acc[cur.name] = send(cur.name)
        end
      end
    end
  end
end
