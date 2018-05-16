# frozen_string_literal: true

require 'sodor/line'
require 'sodor/line/line_set'
require 'set'
require 'forwardable'
require 'sodor/lines/builder'

module Sodor
  class Lines
    extend Forwardable

    attr_reader :lines

    def_delegators(:@lines, :add, :include?, :reject, :tap, :map, :classify, :to_a)

    def initialize(lines = Sodor::Line::LineSet.new)
      raise "Was #{lines.class}" unless lines.instance_of?(Sodor::Line::LineSet)
      @lines = lines
    end

    def routes(origin, destination)
      return SortedSet.new unless routable?(origin, destination)
      []
    end

    def routable?(origin, destination)
      return false unless origin?(origin)
      return false unless destination?(destination)

      true # Maybe.
    end

    def origin?(station)
      origins.key?(station.code)
    end

    # Stations known to have outbound line(s).
    def origins
      @origins ||= @lines.classify { |line| line.origin.code }.freeze
    rescue StandardError => ex
      ap ex
      binding.pry
      puts
    end

    # Is this station known to have an inbound line(s)?
    def destination?(station)
      destinations.key?(station.code)
    end

    # Stations known to have inbound line(s).
    def destinations
      @destinations ||= classify { |line| line.destination.code }.freeze
    end

    # What are the stations that have outbound line(s) directly to this station?
    def origins_for(station)
      destinations[station.code].map(&:origin)
    end

    # What are the stations that have inbound line(s) directly from this station?
    def destinations_for(station)
      origins[station.code].map(&:destination)
    end

    def stations
      @stations ||= StationSet.new(flat_map { |line| [line.destination, line.origin] })
    end
  end
end
