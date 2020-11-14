# frozen_string_literal: true

require 'password_strength/rules/number_rule'

RSpec.describe PasswordStrength::Rules::NumberRule do
  subject { described_class }

  let(:length_rule) { described_class.new(password: password, option: option) }
  let(:password) { '' }
  let(:option) {}

  it { is_expected.to be < PasswordStrength::Rules::Base }

  describe '#passed?' do
    subject(:passed?) { length_rule.passed? }

    describe 'when option is 2' do
      let(:option) { 2 }

      describe 'when password does not contain 2 numbers' do
        let(:password) { 'no_numbers' }

        it { is_expected.to eq false }
      end

      describe 'when password contains at least 2 numbers' do
        let(:password) { 'password1_with_2_numbers' }

        it { is_expected.to eq true }
      end
    end

    describe 'when option is negative' do
      let(:option) { -1 }

      it 'raise error' do
        expect { passed? }.to raise_error PasswordStrength::Rules::InvalidOptionError
      end
    end
  end
end
