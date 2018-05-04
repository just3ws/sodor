# frozen_string_literal: true

module Sodor
  module CLI
    def self.processable?
      ARGF.filename != '-' || !(STDIN.tty? || STDIN.closed?)
    end

    def self.run(app, io)
      io.each_line do |line|
        ap line
      end

      app
    end
  end
end
