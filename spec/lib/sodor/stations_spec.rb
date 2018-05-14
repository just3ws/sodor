# frozen_string_literal: true

require 'sodor/stations'
require 'sodor/station'

module Sodor
  RSpec.describe Stations do
    let(:line_codes) do
      %w[
        AB1
        BC2
        CD3
        DB4
        DC4
      ]
    end

    describe '.build' do
      subject(:stations) { described_class.build(sio) }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      it { is_expected.to be_an_instance_of(Stations) }

      it 'assigns outbound lines to stations' do
        expect(stations[:A].outbound.map(&:code)).to contain_exactly(:B)
        expect(stations[:B].outbound.map(&:code)).to contain_exactly(:C)
        expect(stations[:C].outbound.map(&:code)).to contain_exactly(:D)
        expect(stations[:D].outbound.map(&:code)).to contain_exactly(:B, :C)
      end

      it 'assigns inbound lines to stations' do
        expect(stations[:A].inbound.map(&:code)).to be_empty
        expect(stations[:B].inbound.map(&:code)).to contain_exactly(:A, :D)
        expect(stations[:C].inbound.map(&:code)).to contain_exactly(:B, :D)
        expect(stations[:D].inbound.map(&:code)).to contain_exactly(:C)
      end
    end
  end
end
