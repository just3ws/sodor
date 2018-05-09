# frozen_string_literal: true

require 'sodor/etl/rail_line'
require 'sodor/railroad'

module Sodor
  module CLI
    def self.processable?
      ARGF.filename != '-' || !(STDIN.tty? || STDIN.closed?)
    end

    def self.run(app, io)
      # routes = Sodor::Railroad.new

      to_new_rail_line = lambda do |rail_line|
        Sodor::RailLine.new(
          origin: Sodor::Station.new(name: rail_line.origin),
          destination: Sodor::Station.new(name: rail_line.destination),
          distance: rail_line.distance
        )
      end

      rail_lines = io
                   .each_line
                   .map { |line| Sodor::ETL::RailLine.parse(line) }
                   .map(&to_new_rail_line)

      ap rail_lines

      binding.pry
      puts

      app
    end
  end
end
