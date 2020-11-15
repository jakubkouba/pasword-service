require 'password_strength'

RSpec.describe PasswordStrength do

  describe '.strength_for' do
    let(:password) { 'password' }
    let(:base) { double('Base', state: :good) }

    before { ( expect(PasswordStrength::Base).to receive(:new).and_return(base) ) }

    it 'receives status from base class' do
      expect(base).to receive(:status)

      described_class.strength_for(password)
    end
  end
end
