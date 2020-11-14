require 'password_strength/rules/base'

module PasswordStrength
  module Rules
    class CaseWordsRule < Base

      def initialize(password:, option: nil, score: 15)
        super
      end

      def passed?
        raise InvalidOptionError.new "Option has to be positive integer, but #{option.inspect} given"  unless valid_option?

        regex = /([A-Z]){#{option}}/
        !!password.match(regex)
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

