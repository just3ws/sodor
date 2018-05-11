# frozen_string_literal: true

require 'sodor/x_line'

module Sodor
  class XLines < Set
    def self.build(io)
      io.each_line.each_with_object(Sodor::XLines.new) do |line, lines|
        lines.add(Sodor::XLine.new(line))
      end
    end
  end
end
