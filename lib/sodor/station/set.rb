# frozen_string_literal: true

module Sodor
  class Station
    class Set
      extend Forwardable

      def_delegators(:@stations, :add, :include?, :reject, :tap, :map, :to_a)

      def initialize(stations = SortedSet.new)
        @stations = stations
      end
    end
  end
end
