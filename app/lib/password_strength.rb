# frozen_string_literal: true

class PasswordStrength
  attr_reader :password

  def initialize(password)
    @password = password
  end

  def status
    :weak
  end
end
