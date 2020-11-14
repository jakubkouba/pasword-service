# frozen_string_literal: true

module PasswordStrength
  module Rules
    class Base
      attr_reader :password, :option, :score

      def initialize(password:, option: nil, score: nil)
        @password = password
        @option = option
        @score = score
      end

      def passed?
        raise NotImplementedError
      end

    end

    class InvalidOptionError < StandardError; end
  end
end
