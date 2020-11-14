# frozen_string_literal: true

require 'password_strength/rules/symbol_rule'

RSpec.describe PasswordStrength::Rules::SymbolRule do
  subject { described_class }

  let(:length_rule) { described_class.new(password: password, option: option) }
  let(:password) { '' }
  let(:option) {}

  it { is_expected.to be < PasswordStrength::Rules::Base }

  describe '#passed?' do
    subject(:passed?) { length_rule.passed? }

    describe 'when option is 2' do
      let(:option) { 2 }

      describe 'when password does not contain 2 symbols' do
      describe 'when password doesnt contain 2 symbols' do
        let(:password) { 'no_symbols' }

        it { is_expected.to eq false }
      end

    end
  end
end
