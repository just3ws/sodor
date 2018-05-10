# frozen_string_literal: true

require 'sodor/station'
require 'sodor/rail_line'
require 'set'
require 'forwardable'

module Sodor
  class Railroad
    extend Forwardable

    attr_reader :lines, :stations
    def_delegators :@stations, :[]=, :[], :values

    def initialize
      @stations = {}
    end

    def <<(other)
      other.tap do |line|
        stations[line.origin.name] ||= line.origin
        stations[line.origin.name].lines.outbound.add(line.destination)

        stations[line.destination.name] ||= line.destination
        stations[line.destination.name].lines.inbound.add(line.origin)
      end
    end

    def station_names
      stations.keys
    end
  end
end
