# frozen_string_literal: true

require 'password_strength/base'

RSpec.describe PasswordStrength::Base do
  let(:password_strength) { described_class.new(password) }
  let(:password) { '' }

  describe '#status' do
    subject(:status) { password_strength.status }
    let(:score) { 0 }

    before { allow(password_strength).to receive(:score).and_return(score) }

    describe 'when score is less or equal than 35' do
      let(:score) { 35 }

      it { is_expected.to eq :weak }
    end

    describe 'when score is more than 35 and less or equal than 70' do
      let(:score) { 50 }

      it { is_expected.to eq :good }
    end

    describe 'when score is more than 70' do
      let(:score) { 85 }

      it { is_expected.to eq :strong }
    end
  end

  describe '#score' do
    subject(:score) { password_strength.score }

    describe 'with length rule of score 10' do
      let(:length_rule) { double('LengthRule', score: 10, passed?: true) }
      before { allow(password_strength).to receive(:rules).and_return([length_rule]) }

      context 'when passed' do
        it { is_expected.to eq 10 }
      end

      context 'when failed' do
        let(:length_rule) { double('LengthRule', score: 10, passed?: false) }
        it { is_expected.to eq 0 }
      end
    end

    describe 'with length rule of score 10 and symbol rule of score 20' do
      let(:length_rule) { double('LengthRule', score: 10, passed?: true) }
      let(:symbol_rule) { double('SymbolRule', score: 20, passed?: true) }

      before { allow(password_strength).to receive(:rules).and_return([length_rule, symbol_rule]) }

      context 'when both passed' do
        it { is_expected.to eq 30 }
      end
    end
  end
end
