# frozen_string_literal: true
require 'password_strength/base'

module PasswordStrength

  def self.strength_for(password)
    password_strength = Base.new(password: password, rules: [:length, :sequence, :symbol])
    password_strength.status.to_s
  end

end
