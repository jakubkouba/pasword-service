# frozen_string_literal: true

require 'password_strength/rules/case_words_rule'

RSpec.describe PasswordStrength::Rules::CaseWordsRule do
  subject { described_class }

  let(:length_rule) { described_class.new(password: password, option: option) }
  let(:password) { '' }
  let(:option) {}

  it { is_expected.to be < PasswordStrength::Rules::Base }

  describe '#passed?' do
    subject(:passed?) { length_rule.passed? }

    describe 'when option is 2' do
      let(:option) { 2 }

      describe 'and password does not contain 2 uppercase characters' do
        let(:password) { 'no_uppercase_letters' }

        it { is_expected.to be false }
      end

      describe 'and password contains at least 2 uppercase characters' do
        let(:password) { 'TwO_uppercase_letters' }

        it { is_expected.to be true }
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
