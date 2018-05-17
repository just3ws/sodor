# frozen_string_literal: true

require 'sodor/stations_builder'
require 'sodor/railroad/routes'

module Sodor
  module Railroad
    RSpec.describe Routes do
      subject(:router) { described_class }

      let(:stations) { StationsBuilder.build(sio) }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      context 'with the acceptance criteria' do
        let(:line_codes) { %w[AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7].shuffle }

        # The distance of the route A-B-C.
        # => Output #1: 9
        it 'calculates the distance of the route A-B-C' do
          route = router.find_route_for(stations[:A], stations[:C]).map(&:code)
          distances = router.total_distance_for(route, stations.distances)
          expect(distances).to eq(9)
        end

        # The distance of the route A-D.
        # => Output #2: 5
        it 'calculates the distance of the route A-D' do
          route = router.find_route_for(stations[:A], stations[:D]).map(&:code)
          distances = router.total_distance_for(route, stations.distances)
          expect(distances).to eq(5)
        end

        # The distance of the route A-D-C.
        # => Output #3: 13
        it 'calculates the distance of the route A-D-C' do
          route = %i[A D C]
          distances = router.total_distance_for(route, stations.distances)
          expect(distances).to eq(13)
        end

        # The distance of the route A-E-B-C-D.
        # => Output #4: 22
        it 'calculates the distance of the route A-E-B-C-D' do
          route = %i[A E B C D]
          distances = router.total_distance_for(route, stations.distances)
          expect(distances).to eq(22)
        end

        # The number of trips starting at C and ending at C with a maximum of 3 stops.
        # In the sample data below, there are two such trips: C-D-C (2 stops). and
        # C-E-B-C (3 stops).
        # => Output #6: 2

        # The number of trips starting at A and ending at C with exactly 4 stops. In
        # the sample data below, there are three such trips: A to C (via B,C,D); A to C
        # (via D,C,D); and A to C (via D,E,B).
        # => Output #7: 3

        # The length of the shortest route (in terms of distance to travel) from A to C.
        # => Output #8: 9

        # The length of the shortest route (in terms of distance to travel) from B to B.
        # => Output #9: 9

        # The number of different routes from C to C with a distance of less than 30.
        # In the sample data, the trips are: CDC, CEBC, CEBCDC, CDCEBC, CDEBC, CEBCEBC,
        # CEBCEBCEBC.
        # => Output #10: 7

        # The distance of the route A-E-D.
        # => Output #5: NO SUCH ROUTE
        it 'calculates the distance of the route A-E-D' do
          route = %i[A E D]
          stations = StationsBuilder.build(%w[AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7])

          # router.traversable?(route, stations)
          begin
            router.total_distance_for(route, stations.distances)
          rescue Sodor::Railroad::Routes::NoSuchRouteError => ex
            puts ex.message
          end

          binding.pry
          puts
          # distances = router.find_route_for(route, stations.distances)
          expect(distances).to eq(22)
        end
      end

      context 'with non-existent origin and destination' do
        let(:line_codes) { %w[AB1 BC2].shuffle }

        it { expect(router.find_route_for(stations[:X], stations[:B])).to be_empty }
        it { expect(router.find_route_for(stations[:A], stations[:Y])).to be_empty }
        it { expect(router.find_route_for(stations[:X], stations[:Y])).to be_empty }
      end

      context 'with only a single direct route' do
        subject { router.find_route_for(stations[:A], stations[:B]).map(&:code) }

        let(:line_codes) { %w[AB1] }

        it { is_expected.to eq(%i[A B]) }
      end

      context 'with a direct route' do
        subject { router.find_route_for(stations[:A], stations[:B]).map(&:code) }

        let(:line_codes) { %w[AC1 AB2].shuffle }

        it { is_expected.to eq(%i[A B]) }
      end

      context 'with a single hop route' do
        subject { router.find_route_for(stations[:A], stations[:B]).map(&:code) }

        let(:line_codes) { %w[AC1 CB2].shuffle }

        it { is_expected.to eq(%i[A C B]) }
      end

      context 'with a multiple step route' do
        subject { router.find_route_for(stations[:A], stations[:E]).map(&:code) }

        let(:line_codes) { %w[AD1 BC2 CE3 DB4].shuffle }

        it { is_expected.to eq(%i[A D B C E]) }
      end
    end
  end
end
