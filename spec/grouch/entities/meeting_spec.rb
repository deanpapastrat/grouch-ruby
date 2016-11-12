RSpec.describe Grouch::Meeting do
  subject { Grouch::Meeting.new('Monica Sweat', 'mwf', '8:05am',
    '8:55am', 'lecture', 'Clough Undergraduate Commons 102') }

  describe 'initialize' do
    context 'when all arguments are valid' do
      it 'creates a section object' do
        expect(subject).to be_instance_of(Grouch::Meeting)
      end
    end

    context 'when an argument is nil' do
      subject { Grouch::Meeting.new(nil, 'mwf', '8:05am',
        '8:55am', 'lecture', 'Clough Undergraduate Commons 102') }

      it 'raises an exception' do
        expect { subject }.to(raise_error(ArgumentError,
          'All fields must be present.'))
      end
    end

    context 'when a day is not valid' do
      subject { Grouch::Meeting.new('Monica Sweat', 'z', '8:05am',
        '8:55am', 'lecture', 'Clough Undergraduate Commons 102') }

      it 'raises an exception' do
        expect { subject }.to raise_error(ArgumentError,
          'Invalid days present in string: z.')
      end
    end
  end

  describe '#day_names' do
    it 'returns the full names of the days the meeting occurs' do
      expect(subject.day_names).to(contain_exactly('monday', 'wednesday',
        'friday'))
    end
  end

  describe '#times' do
    it 'returns the meeting times' do
      allow(subject).to(receive(:letter_to_day).and_return('monday',
        'wednesday', 'friday'))
      expect(subject.times).to(contain_exactly(
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
          day: 'friday',
          end_time: '8:55am',
          start_time: '8:05am'
        }
      ))
    end
  end
end
