# frozen_string_literal: true

module Sodor
  class Lines
    module Builder
      module_function

      def build(io)
        io.each_line.map { |line_code| Sodor::LineCode.new(line_code) }.each_with_object(Lines.new) do |line_code, lines|
          lines.add(Line.new(
                      Station.new(line_code.origin),
                      Station.new(line_code.destination),
                      line_code.distance
                    ))
        end
      end
    end
  end
end
