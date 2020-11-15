require 'password_strength'

RSpec.describe PasswordStrength do

  describe '.for' do
    let(:password) { 'password' }
    let(:base) { double(PasswordStrength::Base, status: :good, apply_rule: true) }

    before { ( expect(PasswordStrength::Base).to receive(:new).and_return(base) ) }

    it 'returns PasswordStrength::Base instance' do
      expect(described_class.for(password)).to be base
    end

    it 'yields the block with base class' do
      expect { |b| described_class.for(password, &b) }.to yield_with_args(base)
    end
  end
end
