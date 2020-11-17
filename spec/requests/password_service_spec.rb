# frozen_string_literal: true

require 'json'
require 'password_service'

RSpec.describe 'Password Service' do
  describe 'POST /api/v1/password-strength' do
    subject(:strength) { JSON.parse(last_response.body)['status'] }
    let(:password) { '' }

    before { post '/api/v1/password-strength', { password: password } }

    it 'responds with 200' do
      expect(last_response).to be_ok
    end

    describe 'when password is abc' do
      let(:password) { 'abc' }

      it { is_expected.to eq 'weak' }
    end

    describe 'when password contains capital letter, number and is long enough but contains sequence' do
      let(:password) { 'Abccc1def' }

      it { is_expected.to eq 'good' }
    end

    describe 'when password contains capital letter, number, is long enough contains special character but in sequence' do
      let(:password) { 'Ab@@@1def' }

      it { is_expected.to eq 'good' }
    end

    describe 'when password contains capital letters, symbol, number, without sequence and is long enough' do
      let(:password) { 'H@2blac' }

      it { is_expected.to eq 'strong' }
    end
  end
end
