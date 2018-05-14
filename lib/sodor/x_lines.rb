# frozen_string_literal: true

require 'sodor/x_line'

module Sodor
  class XLines < Set
    def routes(origin_station, destination_station)
      return Set.new unless routable?(origin_station, destination_station)
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
      @origins ||= classify { |x_line| x_line.origin.code }.freeze
    end

    # Is this station known to have an inbound line(s)?
    def destination?(station)
      destinations.key?(station.code)
    end

    # Stations known to have inbound line(s).
    def destinations
      @destinations ||= classify { |x_line| x_line.destination.code }.freeze
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
                      flat_map { |x_line| [x_line.destination, x_line.origin] }.sort.uniq.freeze
                    end
    end

    def self.build(io)
      io.each_line.each_with_object(XLines.new) do |line_code, x_lines|
        x_lines.add(Sodor::XLine.new(line_code))
      end
    end
  end
end
