# frozen_string_literal: true

require 'password_strength/rules/base'

module PasswordStrength
  module Rules
    class CaseWordsRule < Base
      def initialize(password:, option: 1, score: 15)
        super
      end

      def passed?
        raise InvalidOptionError, "Option has to be positive integer, but #{option.inspect} given" unless valid_option?

        regex = /([A-Z])/
        password.scan(regex).count == option
      end

      private

      def valid_option?
        return false unless option.class == Integer
        return false if option < 1

        true
      end
    end
  end
end
