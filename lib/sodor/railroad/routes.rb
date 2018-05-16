# frozen_string_literal: true

module Sodor
  module Railroad
    module Routes
      module_function

      def find_route_for(origin, destination, visited_stations: [])
        return [] if origin.nil? || destination.nil?

        visited_stations.push(origin) if visited_stations.empty?

        # Direct connection
        return visited_stations.push(destination) if origin.departs_to?(destination)

        unvisited_stations_stations = origin.outbound.reject { |station| visited_stations.include?(station) }

        unvisited_stations_stations.each do |station|
          visited_stations.push(station)

          break if station.departs_to?(destination)

          find_route_for(station, destination, visited_stations: visited_stations)
        end

        visited_stations.push(destination)
      end
    end
  end
end
