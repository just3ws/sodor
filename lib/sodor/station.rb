# frozen_string_literal: true

module Sodor
  class Station
    class Inbound < SortedSet
    end

    class Outbound < SortedSet
    end

    include Comparable

    attr_reader :code, :inbound, :outbound

    def initialize(code)
      @code = code.to_sym

      @inbound = Inbound.new
      @outbound = Outbound.new
    end

    def departs_to?(station)
      outbound.include?(station)
    end

    def <=>(other)
      code <=> other.code
    end

    def eql?(other)
      code.casecmp?(other.code)
    end
    alias == eql?

    def inspect
      [code, { inbound: inbound.map(&:code), outbound: outbound.map(&:code) }]
    end
  end
end
