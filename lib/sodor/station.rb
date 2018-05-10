# frozen_string_literal: true

require 'set'
require 'ostruct'

module Sodor
  class Station
    attr_reader :name, :lines

    def initialize(name:)
      @name = name.freeze
      @lines = OpenStruct.new(inbound: Set.new, outbound: Set.new)
    end

    def eql?(other)
      name.casecmp?(other.name)
    end
    alias == eql?
  end
end
