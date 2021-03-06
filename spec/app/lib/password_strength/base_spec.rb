# frozen_string_literal: true

require 'password_strength/base'

RSpec.describe PasswordStrength::Base do
  let(:password_strength) { described_class.new(password: password) }
  let(:password) { '' }

  describe '#status' do
    subject(:status) { password_strength.status }
    let(:score) { 0 }
    let(:good_password_threshold) { 0 }
    let(:strong_password_threshold) { 10 }

    before do
      allow(password_strength).to receive(:score).and_return(score)
      allow(password_strength).to receive(:good_password_threshold).and_return(good_password_threshold)
      allow(password_strength).to receive(:strong_password_threshold).and_return(strong_password_threshold)
    end

    describe 'when score is less than good password threshold' do
      let(:score) { 30 }
      let(:good_password_threshold) { 40 }

      it { is_expected.to eq :weak }
    end

    describe 'when score between good and strong threshold inclusively' do
      let(:score) { 35 }
      let(:good_password_threshold) { 35 }
      let(:strong_password_threshold) { 70 }

      it { is_expected.to eq :good }
    end

    describe 'when score is less than or equal strong password threshold' do
      let(:score) { 70 }
      let(:strong_password_threshold) { 70 }

      it { is_expected.to eq :good }
    end

    describe 'when score is more or then strong password threshold' do
      let(:score) { 75 }
      let(:strong_password_threshold) { 70 }

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

  describe '#set_threshold' do
    subject(:set_threshold) { password_strength.set_strength_threshold(threshold) }
    let(:threshold) { {} }

    describe 'when threshold is hash like { good: 35 }' do
      let(:threshold) { { good: 35 } }

      it 'set value 35 to good_password_threshold' do
        subject

        expect(password_strength.good_password_threshold).to eq 35
      end
    end

    describe 'when threshold is hash like { strong: 70 }' do
      let(:threshold) { { strong: 70 } }

      it 'set value 70 to strong_password_threshold' do
        subject

        expect(password_strength.strong_password_threshold).to eq 70
      end
    end

    describe 'when threshold is not hash' do
      let(:threshold) { 'strong' }

      it 'does not set password strength' do
        subject

        expect(password_strength.strong_password_threshold).to eq nil
        expect(password_strength.good_password_threshold).to eq nil
      end
    end
  end

  describe '#apply_rule' do
    subject(:apply_rule) { password_strength.apply_rule(rule_name, options) }
    let(:rule_name) { :some }
    let(:options) { { score: 1, option: 1} }
    let(:password) { 'password' }

    context 'when length rule class exists' do
      class SomeRule
        def initialize(password); end

        def parameterize
          'some'
        end
      end

      it 'adds instance of rule class to the list of rules' do
        apply_rule

        expect(password_strength.rules.count).to eq 1
        expect(password_strength.rules.values.first).to be_an_instance_of SomeRule
      end

      context 'when applying the same rule twice' do

        before { password_strength.apply_rule(rule_name, options) }

        it 'does not add the the rule' do
          apply_rule

          expect(password_strength.rules.count).to eq 1
        end
      end
    end

    context 'when rule does not exists' do
      let(:rule_name) { :not_exists }
      let(:options) { {} }

      it 'raise error' do
        expect { apply_rule }.to raise_error PasswordStrength::InvalidPasswordRuleDefinition
      end
    end
  end
end
