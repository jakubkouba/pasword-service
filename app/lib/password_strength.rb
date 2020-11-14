# frozen_string_literal: true
require 'password_strength/base'

module PasswordStrength

  def self.status(password)
    password_strength = Base.new(password)
    password_strength.status
  end

end
