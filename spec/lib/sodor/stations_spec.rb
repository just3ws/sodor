# frozen_string_literal: true

require 'sodor/stations'
require 'sodor/station'
require 'sodor/railroad/routes'

module Sodor
  RSpec.describe Stations do
    subject(:stations) { Sodor::StationsBuilder.build(sio) }

    let(:line_codes) { %w[AB1 BC2 CD3 DB4 DC4 DE5 FG1 GH2] }

    let(:sio) do
      StringIO.new.tap do |io|
        line_codes.each { |line_code| io.puts(line_code) }
        io.rewind
      end
    end

    it { is_expected.to be_an_instance_of(Stations) }

    it { expect(stations[:A].outbound.map(&:code)).to contain_exactly(:B) }
    it { expect(stations[:B].outbound.map(&:code)).to contain_exactly(:C) }
    it { expect(stations[:C].outbound.map(&:code)).to contain_exactly(:D) }
    it { expect(stations[:D].outbound.map(&:code)).to contain_exactly(:B, :C, :E) }

    it { expect(stations[:A].inbound.map(&:code)).to be_empty }
    it { expect(stations[:B].inbound.map(&:code)).to contain_exactly(:A, :D) }
    it { expect(stations[:C].inbound.map(&:code)).to contain_exactly(:B, :D) }
    it { expect(stations[:D].inbound.map(&:code)).to contain_exactly(:C) }
    it { expect(stations[:E].inbound.map(&:code)).to contain_exactly(:D) }
  end
end
