# frozen_string_literal: true

require 'password_strength/rules/black_list_rule'

RSpec.describe PasswordStrength::Rules::BlackListRule do
  subject { described_class }

  let(:black_list_rule) { described_class.new(password: password, option: option, score: 10) }
  let(:password) { '' }
  let(:option) {}

  it { is_expected.to be < PasswordStrength::Rules::Base }

  it 'has BLACK_LIST_FILE_DIR pointed to password_strength/conf' do
    expect(described_class::BLACK_LIST_FILE_DIR).to match('app/lib/password_strength/conf')
  end

  describe '#passed?' do
    subject(:passed?) { black_list_rule.passed? }
    let(:password_black_list_file_path) { File.expand_path('../../../../../support', __FILE__ ) }

    before { stub_const("#{described_class}::BLACK_LIST_FILE_DIR", password_black_list_file_path) }

    describe 'when password is not in the list of blacklisted passwords' do
      let(:password) { 'not_in_the_black_list'}

      it { is_expected.to be true }
    end

    describe 'when password is in the list of blacklisted passwords' do
      let(:password) { 'player'}

      it { is_expected.to be false }
    end
  end
end
