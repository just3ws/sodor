# frozen_string_literal: true

require 'sodor/x_line'

module Sodor
  class XLines < Set
    def routes(origin_station_code, destination_station_code)
      # ap [:routes, [origin_station_code, destination_station_code]]

      # ap 'routable?'
      return Set.new unless routable?(origin_station_code, destination_station_code)

      Set.new.tap do |r|
        o = origins[origin_station_code]

        return Set.new if o.empty?

        # Did we arrive at our destination?
        d = o.select { |x_line| x_line.destination == destination_station_code }

        r << [origin_station_code, destination_station_code] if d.any?
      end
    end

    def routable?(origin_station_code, destination_station_code)
      return false unless origin?(origin_station_code)
      return false unless destination?(destination_station_code)

      true # Maybe.
    end

    def origin?(station_code)
      origins.key?(station_code)
    end

    def destination?(station_code)
      destinations.key?(station_code)
    end

    def self.build(io)
      io.each_line.each_with_object(XLines.new) do |line_code, x_lines|
        x_lines.add(Sodor::XLine.new(line_code))
      end
    end

    def origins
      @origins ||= classify(&:origin).freeze
    end

    def origin_names
      @origin_names ||= origins.keys.freeze
    end

    def destinations
      @destinations ||= classify(&:destination).freeze
    end

    def destination_names
      @destination_names ||= destinations.keys.freeze
    end

    def station_names
      @station_names ||= flat_map { |x_line| [x_line.destination, x_line.origin] }.sort.uniq.freeze
    end
  end
end
