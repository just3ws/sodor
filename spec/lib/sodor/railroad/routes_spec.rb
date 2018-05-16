# frozen_string_literal: true

require 'sodor/stations'
require 'sodor/stations_builder'
require 'sodor/railroad/routes'

module Sodor
  module Railroad
    RSpec.describe Routes do
      subject(:router) { described_class }

      let(:stations) { Sodor::StationsBuilder.build(sio) }

      let(:line_codes) { %w[AB1 BC2 CD3 DB4 DC4 DE5 FG1 GH2] }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      context 'with non-existent origin and destination' do
        it { expect(router.find_route_for(stations[:X], stations[:B])).to be_empty }
        it { expect(router.find_route_for(stations[:A], stations[:Y])).to be_empty }
        it { expect(router.find_route_for(stations[:X], stations[:Y])).to be_empty }
      end

      context 'with a single direct route' do
        it { expect(router.find_route_for(stations[:A], stations[:B]).map(&:code)).to contain_exactly(:A, :B) }
      end

      context 'with a single hop route' do
        let(:line_codes) { %w[AB1 BC2 CD3] }

        it { expect(router.find_route_for(stations[:A], stations[:C]).map(&:code)).to contain_exactly(:A, :B, :C) }
      end
    end
  end
end
