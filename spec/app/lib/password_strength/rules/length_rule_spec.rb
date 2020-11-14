require 'password_strength/rules/length_rule'

RSpec.describe PasswordStrength::Rules::LengthRule do
  subject { described_class }

  let(:length_rule) { described_class.new(password: password, option: option) }
  let(:password) { '' }
  let(:option) { }

  it { is_expected.to be < PasswordStrength::Rules::Base }

  describe '#passed?' do
    subject(:passed?) { length_rule.passed? }

    context "with option is 6" do
      let(:option) { 6 }

      describe 'when password is "aaa"' do
        let(:password) { 'a' * 3 }

        it { is_expected.to be false }
      end
    end
  end
end