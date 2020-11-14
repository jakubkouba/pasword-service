# frozen_string_literal: true

require 'password_strength/rules/sequence_rule'

RSpec.describe PasswordStrength::Rules::SequenceRule do
  subject { described_class }

  let(:sequence_rule) { described_class.new(password: password, option: option) }
  let(:password) { '' }
  let(:option) {}

  it { is_expected.to be < PasswordStrength::Rules::Base }

  describe '#passed?' do
    subject(:passed?) { sequence_rule.passed? }

    describe 'when option is 2' do
      let(:option) { 2 }

      describe 'and password does not contain 2 subsequent letters' do
        let(:password) { 'abcde' }

        it { is_expected.to eq true }
      end

      describe 'and password contains 2 subsequent symbols' do
        let(:password) { 'abbbc' }

        it { is_expected.to eq false }
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
