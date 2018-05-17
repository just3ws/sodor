# frozen_string_literal: true

module Sodor
  module Railroad
    module Routes
      class NoSuchRouteError < StandardError
        MESSAGE = 'NO SUCH ROUTE'

        attr_accessor :message

        def initialize(route: nil)
          @message = if route.respond_to?(:join)
                       "#{MESSAGE}: #{route.join('-')}"
                     else
                       MESSAGE
                     end
        end

        def to_s
          message
        end
      end

      module_function

      def total_distance_for(route, distances)
        route.each_cons(2).sum { |trip| distances[trip] }
      rescue TypeError => ex
        raise NoSuchRouteError, route: route
      end

      def traversable?(route, stations)
        route.each_cons(2) do |origin, destination|
          ap [origin, destination, find_route_for(stations[origin], stations[destination]).count]
        end
      end

      def find_route_for(origin, destination, visited_stations: Set[])
        return Set[] if origin.nil? || destination.nil?

        visited_stations.add(origin) if visited_stations.empty?

        # Direct connection
        return visited_stations.add(destination) if origin.departs_to?(destination)

        unvisited_stations_stations = origin.outbound.reject { |station| visited_stations.include?(station) }

        unvisited_stations_stations.each do |station|
          visited_stations.add(station)

          break if station.departs_to?(destination)

          find_route_for(station, destination, visited_stations: visited_stations)
        end

        visited_stations.add(destination)
      end
    end
  end
end
