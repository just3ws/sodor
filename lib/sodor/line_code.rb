# frozen_string_literal: true

module Sodor
  class LineCode
    attr_reader :origin, :destination, :distance

    def initialize(line_code)
      tokens = LineCode.parse(line_code)
      @origin = tokens.shift.to_sym
      @destination = tokens.shift.to_sym
      @distance = Integer(tokens.shift)
    end

    def self.parse(line_code)
      line_code.strip.upcase.split('')
    end
  end
end
