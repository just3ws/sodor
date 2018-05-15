# frozen_string_literal: true

require 'sodor/line'

module Sodor
  class Lines < SortedSet
    def routes(origin_station, destination_station)
      return SortedSet.new unless routable?(origin_station, destination_station)
    end

    def routable?(origin_station, destination_station)
      return false unless origin?(origin_station)
      return false unless destination?(destination_station)

      true # Maybe.
    end

    def origin?(station)
      origins.key?(station.code)
    end

    # Stations known to have outbound line(s).
    def origins
      @origins ||= classify { |line| line.origin.code }.freeze
    end

    # Is this station known to have an inbound line(s)?
    def destination?(station)
      destinations.key?(station.code)
    end

    # Stations known to have inbound line(s).
    def destinations
      @destinations ||= classify { |line| line.destination.code }.freeze
    end

    # What are the stations that have outbound line(s) directly to this station?
    def origins_for(station)
      destinations[station.code].map(&:origin)
    end

    # What are the stations that have inbound line(s) directly from this station?
    def destinations_for(station)
      origins[station.code].map(&:destination)
    end

    def stations
      @stations ||= begin
                      flat_map { |line| [line.destination, line.origin] }.sort.uniq.freeze
                    end
    end

    def self.build(io)
      # io.each_line.each_with_object(Lines.new) do |line_code, lines|
      io.each_line.map { |line_code| Sodor::LineCode.parse(line_code) }.each_with_object(Lines.new) do |line_code, lines|
        ap line_code

        line = Line.new(
          Station.new(line_code.origin),
          Station.new(line_code.destination),
          line_code.distance
        )
        lines.add(line)
      end
    end
  end
end
