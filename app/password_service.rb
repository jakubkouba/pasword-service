class PasswordService < Sinatra::Base

  post '/strength' do
    password_strength = PasswordStrength.new(params['password'])
    password_strength.state
  end

end
