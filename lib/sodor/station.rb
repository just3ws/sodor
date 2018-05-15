# frozen_string_literal: true

module Sodor
  class Station
    include Comparable

    attr_reader :code, :inbound, :outbound

    def initialize(code)
      @code = code.to_sym

      @inbound = SortedSet.new
      @outbound = SortedSet.new
    end

    def <=>(other)
      code <=> other.code
    end

    def eql?(other)
      code.casecmp?(other.code)
    end
    alias == eql?
  end
end
