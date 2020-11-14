require 'password_strength/rules/case_words_rule'

RSpec.describe PasswordStrength::Rules::CaseWordsRule do
  subject { described_class }

  let(:length_rule) { described_class.new(password: password, option: option) }
  let(:password) { '' }
  let(:option) { }

  it { is_expected.to be < PasswordStrength::Rules::Base }

  describe '#passed?' do
    subject(:passed?) { length_rule.passed? }

    describe 'when option is 2' do
      let(:option) { 2 }

      describe 'when password does not contain 2 upper case characters' do
        let(:password) { 'no_uppercase_letters' }

        it { is_expected.to be false }
      end

      describe 'when password contains at least 2 upper case characters' do
        let(:password) { 'TWo_uppercase_letters' }

        it { is_expected.to be true }
      end
    end
  end
end
