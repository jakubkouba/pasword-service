require_relative  '../../app/password_service'

RSpec.describe 'Password Service' do

  describe 'POST /strength' do

    it 'responds with 200' do
      post '/strength', { password: 'abc'}

      expect(last_response).to be_ok
      expect(last_response.body).to eq 'weak'
    end
  end
end
