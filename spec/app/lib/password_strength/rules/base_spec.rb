# frozen_string_literal: true

require 'password_strength/rules/base'

RSpec.describe PasswordStrength::Rules::Base do
  let(:base_rule) { described_class.new(password: password) }
  let(:password) { 'password' }

  it 'responds to #passed?' do
    expect(base_rule).to respond_to(:passed?)
  end

  it 'responds to #score' do
    expect(base_rule).to respond_to(:score)
  end
end
