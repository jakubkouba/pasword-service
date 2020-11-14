require 'password_strength/rules/base'

module PasswordStrength
  module Rules
    class CaseWordsRule < Base

      def initialize(password:, option: nil, score: 15)
        super
      end

      def passed?
        regex = /([A-Z]){#{option}}/
        !!password.match(regex)
      end
      end

    end
  end
end

