# frozen_string_literal: true

require 'sodor/x_line'

module Sodor
  RSpec.describe XLine do
    subject { described_class.new(line_code) }

    let(:line_code) { 'AB1' }

    it 'initializes a new frozen instance' do
      expect(subject).to be_frozen
    end

    it 'sets the origin station code' do
      expect(subject.origin).to eq(:A)
    end

    it { is_expected.origin.to eq(:a) }

    it 'sets the destination station code' do
      expect(subject.destination).to eq(:B)
    end

    it 'sets the distance value' do
      expect(subject.distance).to eq(1)
    end
  end
end
