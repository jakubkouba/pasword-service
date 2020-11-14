class PasswordStrengthBase
  attr_reader :rules

  def self.apply_rules(*rules)
    @rules ||= []
    rules.each { |rule| @rules << rule }
  end
end