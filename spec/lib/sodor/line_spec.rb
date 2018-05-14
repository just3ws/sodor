# frozen_string_literal: true

require 'sodor/line'
require 'sodor/station'

module Sodor
  RSpec.describe Line do
    subject(:line) { described_class.new(line_code) }

    let(:line_code) { 'AB1' }

    it { is_expected.to be_frozen }
    it { expect(line.origin).to eq(Station.new(:A)) }
    it { expect(line.destination).to eq(Station.new(:B)) }
    it { expect(line.distance).to equal(1) }
    it { expect(line).to eq(Line.new(line_code)) }
  end
end
