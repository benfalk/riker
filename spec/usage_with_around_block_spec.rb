# frozen_string_literal: true

class SimpleMeasures
  class << self
    def measure(klass, args)
      before_hand(klass, args)
      yield
      after_hand(klass, args)
    end

    def before_hand(_, _); end
    def after_hand(_, _); end
  end
end

class SimpleAddition
  extend Riker

  param :x
  param :y

  around(&SimpleMeasures.method(:measure))

  execute do
    x + y
  end
end

RSpec.describe SimpleAddition do
  let(:inputs) { { x: 7, y: 6 } }

  describe '#run!' do
    subject { described_class.run!(**inputs) }

    it do
      expect(SimpleMeasures).to receive(:before_hand)
        .with(SimpleAddition, { x: 7, y: 6 })

      expect(SimpleMeasures).to receive(:after_hand)
        .with(SimpleAddition, { x: 7, y: 6 })

      expect(subject).to eq(13)
    end
  end

  describe '#run' do
    subject { described_class.run(**inputs) }

    it do
      expect(SimpleMeasures).to receive(:before_hand)
        .with(SimpleAddition, { x: 7, y: 6 })

      expect(SimpleMeasures).to receive(:after_hand)
        .with(SimpleAddition, { x: 7, y: 6 })

      expect(subject.valid?).to be(true)
      expect(subject.result).to eq(13)
    end
  end
end
