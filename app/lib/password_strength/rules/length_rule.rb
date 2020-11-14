require 'password_strength/rules/base'

module PasswordStrength
  module Rules
    class LengthRule < Base

      def initialize(password:, option: 6, score: 10)
        super
      end

      def passed?
        password.length >= option
      end

    end
  end
end

