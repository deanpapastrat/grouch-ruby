require 'spec_helper'

RSpec.describe Grouch::Course do
  describe '#full_name' do
    subject(:course) { Grouch::Course.new('CS', 1332,
      'Data Structures and Algorithms', 'fall', 2016, 3, []).full_name }

    it 'presents the full name of the course' do
      expect(subject).to eq('CS 1332 - Data Structures and Algorithms')
    end
  end

  describe '#grading_formats' do
    subject(:course) { Grouch::Course.new('CS', 1332,
      'Data Structures and Algorithms', 'fall', 2016, 3, [],
      grade_basis: grade_basis) }

    context 'when grade_basis exists' do
      let(:grade_basis) { 'lp' }

      it 'returns an array of grading formats' do
        expect(subject.grading_formats).to eq(['letter grade', 'pass/fail'])
      end
    end
    
    context 'when grade_basis is nil' do
      let(:grade_basis) { nil }

      it 'returns an empty array' do
        expect(subject.grading_formats).to eq([])
      end
    end
  end
end
