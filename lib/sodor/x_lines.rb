# frozen_string_literal: true

require 'sodor/x_line'

module Sodor
  class XLines < Set
    def self.build(io)
      io.each_line.each_with_object(XLines.new) do |line_code, x_lines|
        x_lines.add(Sodor::XLine.new(line_code))
      end
    end

    def origins
      @origins ||= classify(&:origin).freeze
    end

    def destinations
      @destinations ||= classify(&:destination).freeze
    end
  end
end
