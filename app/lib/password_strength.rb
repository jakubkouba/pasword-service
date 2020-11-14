# frozen_string_literal: true

class PasswordStrength
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
    10
  end
end
