# frozen_string_literal: true

require 'sodor/line_code'

module Sodor
  class Stations < Hash
    def self.build(io)
      io.each_line.map { |line_code| Sodor::LineCode.parse(line_code) }.each_with_object(Stations.new) do |line_code, stations|
        stations[line_code.origin] ||= Station.new(line_code.origin)
        origin = stations[line_code.origin]

        stations[line_code.destination] ||= Station.new(line_code.destination)
        destination = stations[line_code.destination]

        origin.outbound.add(destination)
        destination.inbound.add(origin)
      end
    end
  end
end
