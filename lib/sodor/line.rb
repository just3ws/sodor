# frozen_string_literal: true

require 'sodor/station'

module Sodor
  class Line
    attr_reader :origin, :destination, :distance

    def initialize(origin:, destination:, distance:)
      @origin = origin
      @destination = destination
      @distance = distance
    end
  end
end
