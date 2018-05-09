# frozen_string_literal: true

require 'sodor/etl/line'
require 'sodor/railroad'

module Sodor
  module CLI
    def self.processable?
      ARGF.filename != '-' || !(STDIN.tty? || STDIN.closed?)
    end

    def self.run(app, io)
      # routes = Sodor::Railroad.new

      to_new_rail_line = lambda do |line|
        Line.new(
          origin: Station.new(name: line.origin),
          destination: Station.new(name: line.destination),
          distance: line.distance
        )
      end

      rail_lines = io
                   .each_line
                   .map { |line| Sodor::ETL::Line.parse(line) }
                   .map(&to_new_rail_line)

      ap rail_lines

      binding.pry
      puts

      app
    end
  end
end
