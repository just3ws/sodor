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
      @stations = Hash.new { |h, k| h[k] = Set.new }
    end

    def <<(other)
      other.tap do |line|
        stations[line.origin.name].add(line)
        stations[line.destination.name] ||= Set.new
      end
    end

    def station_names
      stations.keys
    end
  end
end
