# frozen_string_literal: true

module Sodor
  module LinesBuilder
    module_function

    def build(io)
      io.each_line.map { |line_code| Sodor::LineCode.new(line_code) }.each_with_object(Sodor::Lines.new) do |line_code, lines|
        lines.add(
          Sodor::Line.new(
            Sodor::Station.new(line_code.origin),
            Sodor::Station.new(line_code.destination),
            line_code.distance
          )
        )
      end
    end
  end
end
