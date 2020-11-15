require 'json'

class PasswordStrengthSerializer

  attr_reader :password_strength

  def initialize(password_strength)
    @password_strength = password_strength
  end

  def to_json
    {
      status: password_strength.status,
      score: password_strength.score,
      rules: rules
    }.to_json
  end

  private

  def rules
    password_strength.rules.map { |title, rule| [title, { passed: rule.passed?, score: rule.score}] }.to_h
  end
end