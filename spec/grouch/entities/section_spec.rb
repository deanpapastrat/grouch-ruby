require 'set'
require 'spec_helper'

RSpec.describe Grouch::Section do
  subject { Grouch::Section.new(crn, identifier, instructors, meetings) }
  let(:crn) { '123456' }
  let(:identifier) { 'A1' }
  let(:instructors) { ['Monica Sweat', 'Tommy Rogers'] }
  let(:meeting_1) { instance_double("Grouch::Meeting",
    instructor: 'Monica Sweat', days: 'mwf', start_time: '8:05am',
    end_time: '8:55am', location: 'Clough Undergraduate Commons 102',
    type: 'lecture') }
  let(:meeting_2) { instance_double("Grouch::Meeting",
    instructor: 'Tommy Rogers', days: 'w', start_time: '5:05pm',
    end_time: '6:25pm', location: 'Instructional Center 204',
    type: 'recitation') }

  describe 'initialize' do
    context 'when all arguments are valid' do
      let(:meetings) { [meeting_1, meeting_2] }

      it 'creates a section object' do
        accept_meeting_types
        expect(subject).to be_instance_of(Grouch::Section)
      end
    end

    context 'when an argument is nil' do
      it 'raises an exception' do
        expect { Grouch::Section.new(crn, identifier, nil, nil) }.to(
          raise_error(ArgumentError, 'All fields must be present.'))
      end
    end

    context 'when meetings contains a non-meeting object' do
      let(:meetings) { [double(), double()] }

      it 'raises an exception' do
        expect { subject }.to raise_error(ArgumentError,
          'Meetings argument must contain meeting objects.')
      end
    end
  end

  describe '#meeting_locations' do
    context 'when meetings are present' do
      let(:meetings) { [meeting_1, meeting_2] }

      it 'returns the locations where the section meets' do
        accept_meeting_types
        expect(subject.meeting_locations).to contain_exactly(
          'Clough Undergraduate Commons 102', 'Instructional Center 204')
      end
    end

    context 'when there are no meetings' do
      let(:meetings) { [] }
      it 'returns an empty array' do
        expect(subject.meeting_types).to be_instance_of(Set)
        expect(subject.meeting_types.length).to eq(0)
      end
    end
  end

  describe '#meeting_days' do
    context 'when meetings are present' do
      let(:meetings) { [meeting_1, meeting_2, meeting_2] }

      it 'returns the locations where the section meets' do
        accept_meeting_types
        expect(subject.meeting_days).to contain_exactly(
          'monday', 'wednesday', 'friday')
      end
    end

    context 'when there are no meetings' do
      let(:meetings) { [] }
      it 'returns an empty array' do
        expect(subject.meeting_types).to be_instance_of(Set)
        expect(subject.meeting_types.length).to eq(0)
      end
    end
  end

  describe '#meeting_times' do
    context 'when meetings are present' do
      let(:meetings) { [meeting_1, meeting_2] }

      it 'returns the locations where the section meets' do
        accept_meeting_types
        expect(subject.meeting_times).to(contain_exactly(
          {
            day: 'monday',
            end_time: '8:55am',
            start_time: '8:05am'
          },
          {
            day: 'wednesday',
            end_time: '8:55am',
            start_time: '8:05am'
          },
          {
            day: 'wednesday',
            end_time: '6:25pm',
            start_time: '5:05pm'
          },
          {
            day: 'friday',
            end_time: '8:55am',
            start_time: '8:05am'
          }
        ))
      end
    end

    context 'when there are no meetings' do
      let(:meetings) { [] }
      it 'returns an empty array' do
        expect(subject.meeting_times).to eq([])
      end
    end
  end

  describe '#meeting_types' do
    context 'when meetings are present' do
      let(:meetings) { [meeting_1, meeting_2, meeting_2] }

      it 'returns the locations where the section meets' do
        accept_meeting_types
        expect(subject.meeting_types).to contain_exactly(
          'recitation', 'lecture')
      end
    end

    context 'when there are no meetings' do
      let(:meetings) { [] }
      it 'returns an empty array' do
        expect(subject.meeting_types).to be_instance_of(Set)
        expect(subject.meeting_types.length).to eq(0)
      end
    end
  end

  protected

  # Allow meeting doubles to be looked at as instances of Grouch::Meeting
  def accept_meeting_types
    [meeting_1, meeting_2].each do |meeting|
      allow(meeting).to(receive(:instance_of?).and_return(Grouch::Meeting))
    end
  end
end