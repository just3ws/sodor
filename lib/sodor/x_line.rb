# frozen_string_literal: true

require 'sodor/station'

module Sodor
  class XLine
    attr_reader :origin, :destination, :distance, :hash

    def initialize(line_code)
      Sodor::LineCode.parse(line_code).tap do |tokens|
        @origin = Station.new(tokens.origin)
        @destination = Station.new(tokens.destination)
        @distance = tokens.distance
      end

      @hash ||= "#{@origin.code}#{@destination.code}".to_sym.hash.freeze
      freeze
    end

    def eql?(other)
      hash == other.hash
    end
    alias == eql?
  end
end
