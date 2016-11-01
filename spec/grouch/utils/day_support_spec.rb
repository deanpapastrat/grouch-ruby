require 'spec_helper'

RSpec.describe Grouch::Utils::DaySupport do
  describe "letter_to_day" do
    subject { Grouch::Utils::DaySupport.letter_to_day(letter) }

    context 'with valid day letter' do
      let(:letter) { 'w' }
      
      it 'returns the day name' do
        allow(Grouch::Utils::DaySupport).to(receive(:valid_day_letter?)
          .and_return(true))
        expect(subject).to eq('wednesday')
      end
    end

    context 'with invalid day letter' do
      let(:letter) { 's' }

      it 'raises an ArgumentError' do
        allow(Grouch::Utils::DaySupport).to(receive(:valid_day_letter?)
          .and_return(false))
        expect {subject}.to raise_error(ArgumentError,
          "'s' is not a valid day identifier.")
      end
    end
  end

  describe 'letters_to_days' do
    subject { Grouch::Utils::DaySupport.letters_to_days(letters) }
    let(:letters) { ['m', 's', 'f'] }

    it 'maps letters to day names' do
      allow(Grouch::Utils::DaySupport).to(receive(:string_enumerator)
        .and_return(letters))
      allow(Grouch::Utils::DaySupport).to(receive(:letter_to_day)
        .and_return('monday', 'wednesday', 'friday'))
      expect(subject).to eq(['monday', 'wednesday', 'friday'])
    end
  end

  describe "valid_day_letter?" do
    subject { Grouch::Utils::DaySupport.valid_day_letter?(letter) }

    it 'ignores case' do
      expect(Grouch::Utils::DaySupport.valid_day_letter?('M')).to be(true)
      expect(Grouch::Utils::DaySupport.valid_day_letter?('N')).to be(false)
    end

    context 'with valid day letter' do
      let(:letter) { 'm' }
      
      it 'marks as valid' do
        expect(subject).to be(true)
      end
    end

    context 'with invalid day letter' do
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
    subject { Grouch::Utils::DaySupport.valid_day_letters?(enumerator) }

    context 'with valid day letters' do
      let(:enumerator) { ['m', 's', 'f'] }

      it 'marks as valid' do
        allow(Grouch::Utils::DaySupport).to(receive(:string_enumerator)
          .and_return(enumerator))
        allow(Grouch::Utils::DaySupport).to(receive(:valid_day_letter?)
          .and_return(true))
        expect(subject).to be(true)
      end
    end

    context 'with invalid day letters' do
      let(:enumerator) { ['m', 's', 'f'] }

      it 'marks as invalid' do
        allow(Grouch::Utils::DaySupport).to(receive(:string_enumerator)
          .and_return(enumerator))
        allow(Grouch::Utils::DaySupport).to(receive(:valid_day_letter?)
          .and_return(true, false, true))
        expect(subject).to be(false)
      end
    end

    context 'with no letters' do
      let(:enumerator) { [] }

      it 'marks as invalid' do
        allow(Grouch::Utils::DaySupport).to(receive(:string_enumerator)
          .and_return(enumerator))
        expect(subject).to be(false)
      end
    end
  end
end
