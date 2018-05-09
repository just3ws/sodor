# frozen_string_literal: true

module Sodor
  class Station
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def eql?(other)
      name.casecmp?(other.name)
    end
    alias == eql?
  end
end
