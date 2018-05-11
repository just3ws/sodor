# frozen_string_literal: true

module Sodor
  class XLine
    attr_reader :origin, :destination, :distance, :hash

    def initialize(line_code)
      @line_code = line_code.strip.freeze
      @line_code.split('').tap do |parts|
        @origin = parts[0].to_sym
        @destination = parts[1].to_sym
        @distance = Integer(parts[2])
      end
      @hash ||= "#{@origin}#{@destination}".to_sym.hash.freeze
      freeze
    end

    def eql?(other)
      hash == other.hash
    end
    alias == eql?
  end
end
