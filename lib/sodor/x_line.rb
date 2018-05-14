# frozen_string_literal: true

require 'sodor/station'

module Sodor
  class XLine
    attr_reader :origin, :destination, :distance, :hash

    def initialize(line_code)
      line_code.strip.split('').tap do |parts|
        @origin = Station.new(parts[0])
        @destination = Station.new(parts[1])
        @distance = Integer(parts[2])
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
