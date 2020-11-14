# frozen_string_literal: true

require_relative '../../../app/lib/password_strength'

RSpec.describe PasswordStrength do
  let(:password_strength) { described_class.new(password) }
  let(:password) { '' }

  describe '#status' do
    subject(:status) { password_strength.status }
    let(:score) { 0 }

    before { allow(password_strength).to receive(:score).and_return(score)}

    describe 'when score is less than 35' do
      let(:score) { 35 }

      it { is_expected.to eq :weak }
    end
  end
end
