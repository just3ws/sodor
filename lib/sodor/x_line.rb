# frozen_string_literal: true

module Sodor
  class XLine
    attr_reader :inbound, :outbound, :distance

    def initialize(line)
      @line = line.strip.freeze
      @line.split('').tap do |parts|
        @inbound = parts[0].to_sym
        @outbound = parts[1].to_sym

        @distance = Integer(parts[2])
      end
    end

    def hash
      @hash ||= "#{inbound}#{outbound}".to_sym.hash.freeze
    end

    def eql?(other)
      hash == other.hash
    end
    alias == eql?
  end
end
