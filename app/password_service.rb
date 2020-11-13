class PasswordService < Sinatra::Base

  post '/strength' do
    params['password']
  end

end
