# frozen_string_literal: true

module PasswordStrength
  class Base
    attr_reader :password

    def initialize(password)
      @password = password
    end

    def status
      return :weak if score <= 35
      return :good if score > 35 && score <= 70

      :strong if score > 70
    end

    def score
      rules.reduce(0) do |total_score, rule|
        total_score += rule.score if rule.passed?
        total_score
      end
    end
  end
end
