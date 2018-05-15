# frozen_string_literal: true

require 'sodor/line_code'

module Sodor
  class Stations < Hash
    def self.trip_builder(_stations, origin, destination, visited: [])
      visited.push(origin) if visited.empty?

      # origin = stations[:A]
      # destination = stations[:C]

      are_we_there_yet = origin.departs_to?(destination)
      # no

      unvisited_stations = origin.outbound.reject { |station| visited.include?(station) }

      unvisited_stations.each do |station|
        visited.push(station)

        break if station.departs_to?(destination)
      end

      visited.push(destination)

      visited
    end

    def self.build(io)
      Stations.new.tap do |stations|
        io.each_line.map { |line_code| Sodor::LineCode.parse(line_code) }.each do |line_code|
          stations[line_code.origin] ||= Station.new(line_code.origin)
          origin = stations[line_code.origin]

          stations[line_code.destination] ||= Station.new(line_code.destination)
          destination = stations[line_code.destination]

          origin.outbound.add(destination.freeze)
          destination.inbound.add(origin.freeze)
        end

        stations.freeze
      end
    end
  end
end
