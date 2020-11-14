# frozen_string_literal: true

require 'password_strength/rules/length_rule'
require 'password_strength/rules/number_rule'
require 'password_strength/rules/sequence_rule'
require 'password_strength/rules/symbol_rule'

module PasswordStrength
  class Base
    attr_reader :password

    def initialize(password:, rules: [])
      @password = password
      @rules = {}
      load_rules(rules)
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

    def apply_rule(rule)
      @rules[rule] = load_rule(rule)
    end

    def rules
      @rules.values
    end

    private

    def rule_class(rule)
      Kernel.const_get "PasswordStrength::Rules::#{rule.to_s.split('_').map(&:capitalize).join}Rule"
    end

    def load_rules(rules)
      rules.each { |rule| @rules[rule] = load_rule(rule) }
    end

    def load_rule(rule)
      rule_class(rule).new(password: password)
    end
  end
end
