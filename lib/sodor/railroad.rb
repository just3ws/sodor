# frozen_string_literal: true

require 'sodor/station'
require 'sodor/rail_line'
require 'tsort'
require 'set'
require 'forwardable'

module Sodor
  class Railroad
    extend Forwardable
    include TSort

    attr_reader :lines
    def_delegators :@hash, :[]=, :[], :values

    def initialize
      @hash = Hash.new { |h, k| h[k] = Set.new }
    end

    def stations
      @hash.keys
    end

    # def +(other)
    #   @lines.add(other)
    # end

    def +(other)
      other.tap do |line|
        @hash[line.origin] ||= line
        @hash[line.destination] ||= Set.new
      end
    end

    # alias tsort_each_node each_key

    # def tsort_each_child(node, &block)
    #   ap [node, block]
    #   fetch(node).each(&block)
    # end
  end
end
