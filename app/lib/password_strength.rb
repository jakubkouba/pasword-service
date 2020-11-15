# frozen_string_literal: true
require 'password_strength/base'

module PasswordStrength

  def self.for(password)
    password_strength = Base.new(password: password, rules: [:length, :number, :symbol])
    yield(password_strength) if block_given?

    password_strength
  end
end
