# frozen_string_literal: true

require 'sodor/line_code'
require 'sodor/stations_builder'
require 'forwardable'

module Sodor
  class Stations
    extend Forwardable

    attr_reader :distances

    def_delegators(:@stations, :[]=, :[], :values, :keys)

    def initialize(stations = {})
      @stations = stations
      @distances = {}
    end
  end
end
