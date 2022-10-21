# frozen_string_literal: true

class SimpleGreeting
  extend Riker

  param :first_name
  param :last_name, required: false
  param :punctuation, default: '.'

  execute do
    if first_name == 'Voldemort'
      errors.add(:first_name, 'He who shall not be named!')
      return
    end

    return "Hello #{first_name}#{punctuation}" if last_name.nil?

    "Hello #{first_name} #{last_name}#{punctuation}"
  end
end

RSpec.describe SimpleGreeting do
  describe '#run!' do
    let(:inputs) { { first_name: 'Ben' } }
    let(:subject) { described_class.run!(**inputs) }

    it { is_expected.to eq('Hello Ben.') }

    context 'a first and last name' do
      let(:inputs) { { first_name: 'Ben', last_name: 'Falk' } }
      it { is_expected.to eq('Hello Ben Falk.') }
    end

    context 'overriding defaults' do
      let(:inputs) { { first_name: 'Will', punctuation: '!' } }
      it { is_expected.to eq('Hello Will!') }
    end

    it 'requires a first name' do
      expect do
        described_class.run!(last_name: 'Falk')
      end.to raise_error(ArgumentError)
    end
    context 'when execution fails' do
      let(:inputs) { { first_name: 'Voldemort' } }
      it { expect { subject }.to raise_error(Riker::Outcome::ExecutionError) }
    end
  end

  describe '#run' do
    let(:inputs) { { first_name: 'Ben' } }
    let(:outcome) { described_class.run(**inputs) }
    subject { outcome.result }

    it { is_expected.to eq('Hello Ben.') }

    context 'a first and last name' do
      let(:inputs) { { first_name: 'Ben', last_name: 'Falk' } }
      it { is_expected.to eq('Hello Ben Falk.') }
    end

    context 'overriding defaults' do
      let(:inputs) { { first_name: 'Will', punctuation: '!' } }
      it { is_expected.to eq('Hello Will!') }
    end

    context 'when execution fails' do
      let(:inputs) { { first_name: 'Voldemort' } }
      subject { outcome }

      it { is_expected.to be_invalid }

      it 'has an expected error message' do
        expect(subject.errors.messages).to eq(
          ['He who shall not be named!']
        )
      end
    end
  end
end
