require 'password_strength'

class PasswordService < Sinatra::Base

  post '/strength' do
    PasswordStrength.strength_for(params['password']) do |password_strength|
      password_strength.apply_rule :sequence
      password_strength.apply_rule :case_words
      password_strength.apply_rule :black_list
    end
  end

end
