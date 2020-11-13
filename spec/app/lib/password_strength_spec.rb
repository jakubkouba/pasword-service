# frozen_string_literal: true

require_relative '../../../app/lib/password_strength'

RSpec.describe PasswordStrength do
  let(:password_strength) { described_class.new(password) }
  let(:password) { '' }

  describe '#status' do
    subject(:status) { password_strength.status }

    describe 'for "abc"' do
      let(:password) { 'abc' }

      it { is_expected.to eq :weak }
    end
  end
end
