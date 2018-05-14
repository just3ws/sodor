# frozen_string_literal: true

module Sodor
  class Railroad
    module Marshal
      module_function

      def load(io)
        io
          .each_line
          .map(&TO_RAIL_LINE_PARAMS)
          .map(&TO_RAIL_LINE)
          .each_with_object(Railroad.new) { |rail_line, railroad| railroad << rail_line }
      end

      TO_RAIL_LINE = lambda do |rail_line_params|
        RailLine.new(
          origin: Station.new(rail_line_params[:origin]),
          destination: Station.new(rail_line_params[:destination]),
          distance: rail_line_params[:distance]
        )
      end

      TO_RAIL_LINE_PARAMS = lambda do |line|
        {
          origin: line[0].freeze,
          destination: line[1].freeze,
          distance: Integer(line[2..-1])
        }.freeze
      end
    end
  end
end
