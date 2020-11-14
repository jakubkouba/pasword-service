# frozen_string_literal: true

require 'password_strength/rules/base'

module PasswordStrength
  module Rules
    class SequenceRule < Base

      def initialize(password:, option: 3, score: 30)
        super
      end

      def passed?
        raise InvalidOptionError, "Option has to be positive integer, but #{option.inspect} given" unless valid_option?

        return false if contains_sequence?
        true
      end

      def valid_option?
        return false unless option.class == Integer
        return false if option < 1

        true
      end

      private

      def contains_sequence?
        return false if password.length < sequence_length

        find_sequence(password)
      end

      def find_sequence(string, start = 1)
        return false if string.length < sequence_length

        if sequence?(string[0], string[0..sequence_length - 1].reverse)
          true
        else
          find_sequence(password[start..(start + (sequence_length - 1))], start + 1)
        end
      end

      def sequence?(char, string)
        if char == string[0]
          return true if string.length == 1
          sequence?(char, string[1..-1])
        else
          false
        end
      end

      alias :sequence_length :option
    end
  end
end
