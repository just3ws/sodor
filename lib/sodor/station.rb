# frozen_string_literal: true

module Sodor
  class Station
    attr_reader :name
    attr_reader :inbound, :outbound

    def initialize(name:)
      @name = name.freeze
      @inbound = Set.new
      @outbound = Set.new
    end

    def eql?(other)
      name.casecmp?(other.name)
    end
    alias == eql?
  end
end
