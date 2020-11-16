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

      def to_s
        self.class.to_s
      end

      def parameterize(suffix = false)
        parameterized_name = to_s.split('::').last.split(/(?=[A-Z])/).map(&:downcase).join('_')
        return parameterized_name.gsub('_rule', '') unless suffix

        parameterized_name
      end

    end

    class InvalidOptionError < StandardError; end
  end
end
