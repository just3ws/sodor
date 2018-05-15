# frozen_string_literal: true

require 'sodor/station'

module Sodor
  class Line
    include Comparable

    attr_reader :origin, :destination, :distance, :hash

    def initialize(origin, destination, distance)
      @origin = origin
      @destination = destination
      @distance = distance

      @hash ||= "#{@origin.code}#{@destination.code}".to_sym.hash.freeze
      freeze
    end

    def <=>(other)
      origin.hash <=> other.hash
    end

    def eql?(other)
      hash == other.hash
    end
    alias == eql?
  end
end
