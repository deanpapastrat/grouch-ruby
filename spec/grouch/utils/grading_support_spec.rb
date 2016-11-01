require 'spec_helper'

RSpec.describe Grouch::Utils::GradingSupport do
  describe "letter_to_basis" do
    subject { Grouch::Utils::GradingSupport.letter_to_basis(letter) }

    context 'with valid basis' do
      let(:letter) { 'a' }
      
      it 'returns the basis name' do
        allow(Grouch::Utils::GradingSupport).to(receive(:valid_basis_letter?)
          .and_return(true))
        expect(subject).to eq('audit')
      end
    end

    context 'with invalid day letter' do
      let(:letter) { 's' }

      it 'raises an ArgumentError' do
        allow(Grouch::Utils::GradingSupport).to(receive(:valid_basis_letter?)
          .and_return(false))
        expect {subject}.to raise_error(ArgumentError,
          "'s' is not a valid grading basis.")
      end
    end
  end

  describe 'letters_to_bases' do
    subject { Grouch::Utils::GradingSupport.letters_to_bases(letters) }
    let(:letters) { ['a', 'l', 'p'] }

    it 'maps letters to grading bases' do
      allow(Grouch::Utils::GradingSupport).to(receive(:string_enumerator)
        .and_return(letters))
      allow(Grouch::Utils::GradingSupport).to(receive(:letter_to_basis)
        .and_return('audit', 'letter grade', 'pass/fail'))
      expect(subject).to eq(['audit', 'letter grade', 'pass/fail'])
    end
  end

  describe "valid_basis_letter?" do
    subject { Grouch::Utils::GradingSupport.valid_basis_letter?(letter) }

    it 'ignores case' do
      expect(Grouch::Utils::GradingSupport.valid_basis_letter?('P')).to(
        be(true))
      expect(Grouch::Utils::GradingSupport.valid_basis_letter?('N')).to(
        be(false))
    end

    context 'with valid basis letter' do
      let(:letter) { 'l' }
      
      it 'marks as valid' do
        expect(subject).to be(true)
      end
    end

    context 'with invalid basis letter' do
      let(:letter) { 's' }

      it 'marks as invalid' do
        expect(subject).to be(false)
      end
    end

    context 'with nil' do
      let(:letter) { nil }

      it 'marks as invalid' do
        expect(subject).to be(false)
      end
    end
  end

  describe "valid_day_letters?" do
    subject { Grouch::Utils::GradingSupport.valid_basis_letters?(enumerator) }

    context 'with valid basis letters' do
      let(:enumerator) { ['a', 'l', 'p'] }

      it 'marks as valid' do
        allow(Grouch::Utils::GradingSupport).to(receive(:string_enumerator)
          .and_return(enumerator))
        allow(Grouch::Utils::GradingSupport).to(receive(:valid_basis_letter?)
          .and_return(true))
        expect(subject).to be(true)
      end
    end

    context 'with invalid basis letters' do
      let(:enumerator) { ['m', 'a', 'f'] }

      it 'marks as invalid' do
        allow(Grouch::Utils::GradingSupport).to(receive(:string_enumerator)
          .and_return(enumerator))
        allow(Grouch::Utils::GradingSupport).to(receive(:valid_basis_letter?)
          .and_return(false, true, false))
        expect(subject).to be(false)
      end
    end

    context 'with no letters' do
      let(:enumerator) { [] }

      it 'marks as invalid' do
        allow(Grouch::Utils::GradingSupport).to(receive(:string_enumerator)
          .and_return(enumerator))
        expect(subject).to be(false)
      end
    end
  end
end
