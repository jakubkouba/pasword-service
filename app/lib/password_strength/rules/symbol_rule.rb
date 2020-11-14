# frozen_string_literal: true

require 'password_strength/rules/base'

module PasswordStrength
  module Rules
    class SymbolRule < Base

      SYMBOLS = '!@#$%&'

      def initialize(password:, option: 1, score: 15)
        super
      end

      def passed?
        false
      end
    end
  end
end
