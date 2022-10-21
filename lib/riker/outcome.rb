# frozen_string_literal: true

require_relative 'outcome/errors'
require_relative 'outcome/execution_error'

module Riker
  # Wrapped Outcome of a Command
  #
  # Commands may be fallible; and in that case
  # they return an outcome that will either detail
  # the errors that came up during execution or the
  # expected data if it was success.
  #
  class Outcome
    # @return [Object]
    attr_reader :result

    class << self
      # @param result [Object]
      # @return [Riker::Outcome]
      def valid(result)
        new(:valid, result)
      end

      def invalid(errors)
        new(:invalid, errors)
      end

      private :new
    end

    # @param state [:valid, :invalid]
    # @data [Object, Riker::Outcome::Errors]
    def initialize(state, data)
      if state == :valid
        @result = data
      else
        @errors = data
      end
    end

    # @return [Boolean]
    def valid?
      return true unless defined?(@errors)

      @errors.none?
    end

    # @return [Boolean]
    def invalid?
      return false unless defined?(@errors)

      @errors.any?
    end

    # @return [Riker::Outcome::Errors]
    def errors
      @errors ||= Errors.new
    end
  end
end
