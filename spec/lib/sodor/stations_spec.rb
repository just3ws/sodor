# frozen_string_literal: true

require 'sodor/stations'
require 'sodor/station'

module Sodor
  RSpec.fdescribe Stations do
    let(:line_codes) { %w[AB1 BC2 CD3 DB4 DC4 DE5] }

    # let(:line_codes) { %w[AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7] }

    fdescribe '.build' do
      subject(:stations) { described_class.build(sio) }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      xit { is_expected.to be_an_instance_of(Stations) }

      it 'assigns outbound lines to stations' do
        expect(stations[:A].outbound.map(&:code)).to contain_exactly(:B)
        expect(stations[:B].outbound.map(&:code)).to contain_exactly(:C)
        expect(stations[:C].outbound.map(&:code)).to contain_exactly(:D)
        expect(stations[:D].outbound.map(&:code)).to contain_exactly(:B, :C, :E)
      end

      it 'assigns inbound lines to stations' do
        expect(stations[:A].inbound.map(&:code)).to be_empty
        expect(stations[:B].inbound.map(&:code)).to contain_exactly(:A, :D)
        expect(stations[:C].inbound.map(&:code)).to contain_exactly(:B, :D)
        expect(stations[:D].inbound.map(&:code)).to contain_exactly(:C)
        expect(stations[:E].inbound.map(&:code)).to contain_exactly(:D)
      end

      it do
        system('clear')
        # route = Stations.trip_builder(stations[:A], stations[:B])
        # route = Stations.trip_builder(stations[:A], stations[:C])
        route = Stations.trip_builder(stations[:A], stations[:E])

        ap route

        # binding.pry
        # puts
      end
    end
  end
end
