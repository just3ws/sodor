# frozen_string_literal: true

require 'sodor/station'
require 'sodor/rail_line'
require 'tsort'
require 'set'
require 'forwardable'

module Sodor
  class Railroad
    extend Forwardable
    include TSort

    attr_reader :lines, :stations
    def_delegators :@stations, :[]=, :[], :values

    def initialize
      @stations = Hash.new { |h, k| h[k] = Set.new }
    end

    def <<(other)
      other.tap do |line|
        stations[line.origin.name] << line
        stations[line.destination.name] ||= Set.new
      end
    end

    def station_names
      station.keys
    end

    # alias tsort_each_node each_key

    # def tsort_each_child(node, &block)
    #   ap [node, block]
    #   fetch(node).each(&block)
    # end
  end
end
