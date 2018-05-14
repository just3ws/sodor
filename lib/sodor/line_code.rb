# frozen_string_literal: true

module Sodor
  module LineCode
    def self.parse(line_code)
      tokens = line_code.strip.upcase.split('')
      OpenStruct.new(origin: tokens[0].to_sym, destination: tokens[1].to_sym, distance: Integer(tokens[2]))
    end
  end
end
