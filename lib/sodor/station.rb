# frozen_string_literal: true

require 'sodor/station/inbound'
require 'sodor/station/outbound'

module Sodor
  class Station
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
  end
end
