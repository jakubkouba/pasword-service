require 'password_strength'

class PasswordService < Sinatra::Base

  post '/strength' do
    PasswordStrength.strength_for(params['password'])
  end

end
