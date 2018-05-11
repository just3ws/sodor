# frozen_string_literal: true

require 'sodor/x_lines'
require 'sodor/x_line'

module Sodor
  RSpec.describe XLines do
    let(:line_codes) { %w[AB1 BC2] }
    let(:lines) { line_codes.map { |line_code| XLine.new(line_code) } }

    describe '.build' do
      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      it 'builds a new instance from an IO object' do
        expect(described_class.build(sio)).to be_instance_of(XLines)
      end

      context 'with valid input data' do
        subject { described_class.build(sio) }

        it 'has XLine data' do
          expect(subject).to match_array(lines)
        end
      end
    end

    describe '.origins' do
      subject { described_class.new(lines) }

      it 'shows where trains can originate from' do
        ap subject.origins.keys
      end
    end
  end
end
