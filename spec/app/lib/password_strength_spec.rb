require 'password_strength'

RSpec.describe PasswordStrength do

  describe '.strength_for' do
    let(:password) { 'password' }
    let(:base) { double('Base', status: :good, apply_rule: true) }

    before { ( expect(PasswordStrength::Base).to receive(:new).and_return(base) ) }

    it 'receives status from base class' do
      expect(base).to receive(:status)

      described_class.strength_for(password)
    end

    it 'yields the block with base class' do
      expect { |b| described_class.strength_for(password, &b) }.to yield_with_args(base)
    end
  end
end
