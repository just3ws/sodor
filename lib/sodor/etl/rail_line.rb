# frozen_string_literal: true

require 'ostruct'

module Sodor
  module ETL
    module RailLine
      module_function

      def parse(line)
        line.strip!.upcase!

        OpenStruct.new(
          origin: line[0].freeze,
          destination: line[1].freeze,
          distance: Integer(line[2..-1])
        ).freeze
      end
    end
  end
end
