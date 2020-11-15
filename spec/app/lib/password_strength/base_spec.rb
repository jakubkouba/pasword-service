# frozen_string_literal: true

require 'password_strength/base'

RSpec.describe PasswordStrength::Base do
  let(:password_strength) { described_class.new(password: password) }
  let(:password) { '' }

  describe '#status' do
    subject(:status) { password_strength.status }
    let(:score) { 0 }

    before { allow(password_strength).to receive(:score).and_return(score) }

    describe 'when score is less than 35' do
      let(:score) { 30 }

      it { is_expected.to eq :weak }
    end

    describe 'when score is more or equal than 35' do
      let(:score) { 35 }

      it { is_expected.to eq :good }
    end

    describe 'when score is less than 70' do
      let(:score) { 65 }

      it { is_expected.to eq :good }
    end

    describe 'when score is more or equal than 70' do
      let(:score) { 70 }

      it { is_expected.to eq :strong }
    end
  end

  describe '#score' do
    subject(:score) { password_strength.score }

    describe 'with length rule of score 10' do
      let(:length_rule) { double('LengthRule', score: 10, passed?: true) }
      before { allow(password_strength).to receive(:rules).and_return({ length_rule: length_rule }) }

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
      let(:rules) { { length_rule: length_rule, symbol_rule: symbol_rule } }

      before { allow(password_strength).to receive(:rules).and_return(rules) }

      context 'when both passed' do
        it { is_expected.to eq 30 }
      end
    end
  end

  describe '#rules' do
    subject(:rules) { password_strength.rules }

    it { is_expected.to be_a Hash }

    context "when #{described_class} is initialize with a particular rule" do
      let(:password_strength) { described_class.new(password: password, rules: [rule]) }
      let(:rule) { :some }

      context 'and the rule exists' do
        class SomeRule
          def initialize(password); end
        end

        it 'contains that rule' do
          expect(rules.values.first).to be_an_instance_of SomeRule
        end
      end
    end
  end

  describe '#apply_rule' do
    subject(:apply_rule) { password_strength.apply_rule(rule) }
    let(:rule) { :some }
    let(:password) { 'password' }

    context 'when length rule class exists' do
      class SomeRule
        def initialize(password); end
      end

      it 'adds instance of rule class to the list of rules' do
        apply_rule

        expect(password_strength.rules.count).to eq 1
        expect(password_strength.rules.values.first).to be_an_instance_of SomeRule
      end

      context 'when applying the same rule twice' do

        before { password_strength.apply_rule(rule) }

        it 'does not add the the rule' do
          password_strength.apply_rule(rule)

          expect(password_strength.rules.count).to eq 1
        end
      end
    end
  end
end
