require 'password_strength/rules/base'

module PasswordStrength
  module Rules
    class LengthRule < Base

      def initialize(password:, option: nil, score: nil)
        super
      end

      def passed?
        false
      end

    end
  end
end

