# frozen_string_literal: true

module Sodor
  class Station
    attr_reader :code, :lines

    def initialize(code)
      @code = code.to_sym
      # @lines = OpenStruct.new(inbound: Set.new, outbound: Set.new)
    end

    def eql?(other)
      ap other
      code.casecmp?(other.code)
    end
    alias == eql?
  end
end
