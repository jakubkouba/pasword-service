require 'password_strength'

class PasswordService < Sinatra::Base

  post '/strength' do
    PasswordStrength.status(params['password'])
  end

end
