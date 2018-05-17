# frozen_string_literal: true

module Sodor
  module Railroad
    module Routes
      module_function

      def total_distance_for(route, distances)
        route.each_cons(2).sum { |trip| distances[trip] }
      end

      def find_route_for(origin, destination, visited_stations: Set.new)
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
