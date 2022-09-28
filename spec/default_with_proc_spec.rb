# frozen_string_literal: true

class CaptainsLog
  extend Riker

  param :stardate, default: -> { Time.now.to_f }
  param :message

  execute do
    "Captain's Log; Stardate: #{stardate}\n\n#{message}"
  end
end

RSpec.describe CaptainsLog do
  describe '#run!' do
    it 'works with a given value' do
      expect(Time).to_not receive(:now)

      expect(
        described_class.run!(stardate: 29_150.1337, message: 'Test')
      ).to eq("Captain's Log; Stardate: 29150.1337\n\nTest")
    end

    it 'will dynamically run default logic when needed' do
      expect(Time).to receive(:now).and_return(42.1337)

      expect(described_class.run!(message: 'Test')).to eq(
        "Captain's Log; Stardate: 42.1337\n\nTest"
      )
    end
  end
end
