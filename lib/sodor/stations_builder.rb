# frozen_string_literal: true

module Sodor
  module StationsBuilder
    module_function

    def build(io)
      Sodor::Stations.new.tap do |stations|
        io.each_line.map { |line_code| Sodor::LineCode.new(line_code) }.each do |line_code|
          stations[line_code.origin] ||= Sodor::Station.new(line_code.origin)
          origin = stations[line_code.origin]

          stations[line_code.destination] ||= Sodor::Station.new(line_code.destination)
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
