# frozen_string_literal: true

require 'password_strength/rules/symbol_rule'

RSpec.describe PasswordStrength::Rules::SymbolRule do
  subject { described_class }

  let(:symbol_rule) { described_class.new(password: password, option: option) }
  let(:password) { '' }
  let(:option) {}

  it { is_expected.to be < PasswordStrength::Rules::Base }

  describe '#passed?' do
    subject(:passed?) { symbol_rule.passed? }

    describe 'when option is 2' do
      let(:option) { 2 }

      describe 'and password does not contain 2 symbols' do
        let(:password) { 'no_symbols' }

        it { is_expected.to eq false }
      end

      describe 'and password contains exactly 2 symbols' do
        let(:password) { 'password@_with#_symbols' }

        it { is_expected.to eq true }
      end

      describe 'and password contains more than 2 symbols' do
        let(:password) { 'password@_with#_more%_than_two_symbols' }

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
