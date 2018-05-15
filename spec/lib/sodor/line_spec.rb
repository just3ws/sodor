# frozen_string_literal: true

require 'sodor/line'
require 'sodor/station'

module Sodor
  RSpec.describe Line do
    subject(:line) { described_class.new(station_a, station_b, distance) }

    let(:station_a) { Station.new(:A) }
    let(:station_b) { Station.new(:B) }
    let(:distance) { 1 }

    it { is_expected.to be_frozen }
    it { expect(line.origin).to eq(station_a) }
    it { expect(line.destination).to eq(station_b) }
    it { expect(line.distance).to equal(distance) }
    it { expect(line).to eq(Line.new(station_a, station_b, distance)) }
  end
end
