# frozen_string_literal: true

module Sodor
  class Station
    attr_reader :code, :inbound, :outbound

    def initialize(code)
      @code = code.to_sym
      @inbound = Set.new
      @outbound = Set.new
    end

    def eql?(other)
      code.casecmp?(other.code)
    end
    alias == eql?
  end
end
