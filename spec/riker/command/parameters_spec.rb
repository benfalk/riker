# frozen_string_literal: true

RSpec.describe Riker::Command::Parameters do
  let(:instance) { described_class.new }

  describe '#add' do
    it 'returns itself after an add' do
      expect(instance.add(:foo)).to eq(instance)
    end
  end

  context 'with `foo` and an optional `bar`' do
    before do
      instance
        .add(:foo)
        .add(:bar, required: false)
    end

    describe '#ctor_args' do
      subject { instance.ctor_args }
      it { is_expected.to eq('foo: , bar: nil') }
    end

    describe '#variable_sets' do
      subject { instance.variable_sets }
      it { is_expected.to eq(<<~RUBY.strip) }
        @foo = foo
        @bar = bar
      RUBY
    end

    describe 'it works like an enumerable of parameters' do
      subject { instance.map(&:name) }
      it { is_expected.to eq(%i[foo bar]) }
    end
  end
end
