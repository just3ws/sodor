# frozen_string_literal: true

require 'ostruct'
require 'sodor/line'

module Sodor
  module ETL
    module Line
      module_function

      def parse(line)
        line.strip!.upcase!

        Sodor::Line.new(
          origin: line[0].freeze,
          destination: line[1].freeze,
          distance: Integer(line[2..-1])
        ).freeze
      end
    end
  end
end
