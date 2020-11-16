# frozen_string_literal: true

require 'password_strength/rules/black_list_rule'
require 'password_strength/rules/case_words_rule'
require 'password_strength/rules/length_rule'
require 'password_strength/rules/number_rule'
require 'password_strength/rules/symbol_rule'
require 'password_strength/rules/sequence_rule'

module PasswordStrength
  class Base
    attr_reader :password, :rules, :good_password_threshold, :strong_password_threshold

    def initialize(password:)
      @password = password
      @rules = {}
    end

    def status
      return :weak if score < good_password_threshold
      return :good if score.between?(good_password_threshold, strong_password_threshold)

      :strong if score > strong_password_threshold
    end

    def score
      rules.values.reduce(0) do |total_score, rule|
        total_score += rule.score if rule.passed?
        total_score
      end
    end

    def apply_rule(rule)
      @rules[rule] = load_rule(rule)
    end

    def set_strength_threshold(threshold)
      return unless threshold.is_a? Hash

      case threshold.keys.first
      when :good then @good_password_threshold = threshold.values.first
      when :strong then @strong_password_threshold = threshold.values.first
      end
    end

    private

    def rule_class(rule)
      Kernel.const_get "PasswordStrength::Rules::#{rule.to_s.split('_').map(&:capitalize).join}Rule"
    end

    def load_rules(rules)
      rules.each { |rule| @rules[rule] = load_rule(rule) }
    end

    def load_rule(rule)
      return unless rule.is_a? Hash

      rule_name = rule.keys.first
      score = rule.values&.first.fetch(:score, 0) || 0

      rule_class(rule_name).new(password: password, score: score)
    end
  end
end
