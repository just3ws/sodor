# frozen_string_literal: true

require 'sodor/line_code'
require 'forwardable'

module Sodor
  class Stations
    extend Forwardable
    attr_reader :distances

    def_delegators(:@stations, :[]=, :[], :values, :keys)

    def initialize(stations = {})
      @stations = stations

      @distances = {}
    end

    def self.route_finder(origin, destination, visited_stations: [])
      visited_stations.push(origin) if visited_stations.empty?

      # Direct connection
      return visited_stations if origin.departs_to?(destination)

      unvisited_stations_stations = origin.outbound.reject { |station| visited_stations.include?(station) }

      unvisited_stations_stations.each do |station|
        visited_stations.push(station)

        break if station.departs_to?(destination)

        route_finder(station, destination, visited_stations: visited_stations)
      end

      visited_stations
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

          stations.distances[[line_code.origin, line_code.destination].freeze] ||= line_code.distance
        end

        stations.freeze
      end
    end
  end
end
