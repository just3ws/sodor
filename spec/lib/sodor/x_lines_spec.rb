# frozen_string_literal: true

require 'sodor/x_lines'
require 'sodor/x_line'

module Sodor
  RSpec.describe XLines do
    let(:line_codes) { %w[AB1 BC2] }
    let(:lines) { line_codes.map { |line_code| XLine.new(line_code) } }

    describe '.build' do
      subject { described_class.build(sio) }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      it { is_expected.to be_an_instance_of(XLines) }
      it { is_expected.to contain_exactly(*lines) }
    end

    describe '.origin_names' do
      subject { described_class.new(lines).origin_names }

      let(:origin_names) { lines.map(&:origin) }

      it { is_expected.to contain_exactly(*origin_names) }
    end

    describe '.destination_names' do
      subject { described_class.new(lines).destination_names }

      let(:destination_names) { lines.map(&:destination) }

      it { is_expected.to contain_exactly(*destination_names) }
    end
  end
end
