# frozen_string_literal: true

require 'set'
require 'forwardable'

module Sodor
  class Station
    class StationSet
      extend Forwardable

      def_delegators(:@stations, :add, :include?, :reject, :tap, :map)

      def initialize(stations = SortedSet.new)
        @stations = stations
      end
    end
  end
end
