# frozen_string_literal: true

require 'set'

module Sodor
  class Station
    attr_reader :name

    def initialize(name:)
      @name = name.freeze
    end

    def eql?(other)
      name.casecmp?(other.name)
    end
    alias == eql?
  end
end
