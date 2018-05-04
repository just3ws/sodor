# frozen_string_literal: true

require 'awesome_print'

require 'sodor/cli/input'

module Sodor
  module CLI
    def self.processable?
      ARGF.filename != '-' || !(STDIN.tty? || STDIN.closed?)
    end

    def self.run(app, io)
      io.each_line do |line|
        ap Input.parse(line)
      end

      app
    end
  end
end
