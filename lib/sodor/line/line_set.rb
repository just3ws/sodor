# frozen_string_literal: true

require 'set'
require 'forwardable'

module Sodor
  class Line
    class LineSet
      extend Forwardable

      def_delegators(:@lines, :add, :include?, :reject, :tap, :map, :classify, :to_a)

      def initialize(lines = SortedSet.new)
        # raise "Was #{lines.class}" unless lines.instance_of?(SortedSet)
        @lines = SortedSet.new(lines)
      end
    end
  end
end
