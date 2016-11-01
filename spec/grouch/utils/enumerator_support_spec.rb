require 'spec_helper'

RSpec.shared_examples 'an enumerator' do
  it 'should include enumerable' do
    expect(subject.class.included_modules.include?(Enumerable)).to be(true)
  end
end

RSpec.describe Grouch::Utils::EnumeratorSupport do
  let(:test_class) { Class.new { extend Grouch::Utils::EnumeratorSupport } }

  describe 'string_enumerator' do
    subject { test_class.string_enumerator(enumerable) }

    context 'given a string' do
      let(:enumerable) { 'cat' }
      it_behaves_like 'an enumerator'
    end

    context 'given an array' do
      let(:enumerable) { ['d', 'o', 'g'] }
      it_behaves_like 'an enumerator'
    end

    context 'given a non-enumerable' do
      let(:enumerable) { 1234 }
      it 'raises an error' do
        expect{subject}.to raise_error(ArgumentError,
          "'Fixnum' is not mappable.")
      end
    end

    context 'given nil' do
      let(:enumerable) { nil }
      it_behaves_like 'an enumerator'

      it 'should be empty' do
        expect(subject.entries.length).to be(0)
      end
    end
  end
end
