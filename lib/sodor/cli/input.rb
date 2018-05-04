# frozen_string_literal: true

module Sodor
  module CLI
    module Input
      module_function

      def parse(line)
        line.strip!.upcase!

        {
          origin: line[0].freeze,
          destination: line[1].freeze,
          distance: Integer(line[2..-1])
        }.freeze
      end
    end
  end
end
