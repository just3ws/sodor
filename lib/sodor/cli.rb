# frozen_string_literal: true

require 'sodor/railroad'
require 'sodor/railroad/marshal'

module Sodor
  module CLI
    def self.run(app, io)
      railroad = Sodor::Railroad::Marshal.load(io)
      app.new(railroad: railroad)
    end

    def self.processable?
      ARGF.filename != '-' || !(STDIN.tty? || STDIN.closed?)
    end
  end
end
