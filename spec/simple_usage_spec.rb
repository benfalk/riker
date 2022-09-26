# frozen_string_literal: true

class SimpleGreeting
  extend Riker

  param :first_name
  param :last_name, required: false

  execute do
    "Hello #{first_name} #{last_name}".strip
  end
end

RSpec.describe SimpleGreeting do
  describe '#run!' do
    it 'works with just a first name' do
      expect(described_class.run!(first_name: 'Ben')).to eq('Hello Ben')
    end

    it 'works with a first and last name' do
      expect(
        described_class.run!(first_name: 'Ben', last_name: 'Falk')
      ).to eq('Hello Ben Falk')
    end

    it 'requires a first name' do
      expect do
        described_class.run!(last_name: 'Falk')
      end.to raise_error(ArgumentError)
    end
  end
end