# frozen_string_literal: true

require 'sodor/station'
require 'sodor/line'

module Sodor
  RSpec.describe Line do
    let(:origin) { Station.new(name: 'A') }
    let(:destination) { Station.new(name: 'B') }
    let(:distance) { 5 }

    subject do
      described_class.new(
        origin: origin,
        destination: destination,
        distance: distance
      )
    end

    it 'has an originating station' do
      expect(subject.origin).to eq(origin)
    end

    it 'has a destination station' do
      expect(subject.destination).to eq(destination)
    end

    it 'has a distance between stations' do
      expect(subject.distance).to eq(distance)
    end
  end
end
