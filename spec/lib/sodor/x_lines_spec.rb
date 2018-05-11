# frozen_string_literal: true

require 'sodor/x_lines'
require 'awesome_print'

module Sodor
  RSpec.describe XLines do
    describe '.build' do
      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      let(:line_codes) { %w[AB1 BC2] }
      let(:lines) { line_codes.map { |line_code| Sodor::XLine.new(line_code) } }

      it 'builds a new instance from an IO object' do
        expect(described_class.build(sio)).to be_instance_of(Sodor::XLines)
      end

      context 'with valid input data' do
        subject { described_class.build(sio) }

        it 'has XLine data' do
          expect(subject).to match_array(lines)
        end
      end
    end
  end
end
