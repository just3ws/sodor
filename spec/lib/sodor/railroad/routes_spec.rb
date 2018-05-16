# frozen_string_literal: true

require 'sodor/stations_builder'
require 'sodor/railroad/routes'

module Sodor
  module Railroad
    RSpec.describe Routes do
      subject(:router) { described_class }

      let(:stations) { Sodor::StationsBuilder.build(sio) }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      context 'with non-existent origin and destination' do
        let(:line_codes) { %w[AB1 BC2] }

        it { expect(router.find_route_for(stations[:X], stations[:B])).to be_empty }
        it { expect(router.find_route_for(stations[:A], stations[:Y])).to be_empty }
        it { expect(router.find_route_for(stations[:X], stations[:Y])).to be_empty }
      end

      context 'with a single direct route' do
        subject { router.find_route_for(stations[:A], stations[:B]).map(&:code) }

        let(:line_codes) { %w[AB1 BC2] }

        it { is_expected.to contain_exactly(:A, :B) }
      end

      context 'with a single hop route' do
        subject { router.find_route_for(stations[:A], stations[:C]).map(&:code) }

        let(:line_codes) { %w[AB1 BC2] }

        it { is_expected.to contain_exactly(:A, :B, :C) }
      end
    end
  end
end
