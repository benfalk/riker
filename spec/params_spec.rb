# frozen_string_literal: true

class ParamsTest
  extend Riker

  param :first_name
  param :last_name

  execute do
    params
  end
end

RSpec.describe ParamsTest do
  describe '#run!' do
    let(:inputs) { { first_name: 'Ben', last_name: 'Murray' } }
    let(:subject) { described_class.run!(**inputs) }

    it { is_expected.to eq(inputs) }
  end
end
