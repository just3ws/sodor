# frozen_string_literal: true

module Sodor
  module CLI
    def self.run(app, io)
      # app.new(railroad: Sodor::Railroad::Marshal.load(io))
    end

    def self.processable?
      ARGF.filename != '-' || !(STDIN.tty? || STDIN.closed?)
    end
  end
end
