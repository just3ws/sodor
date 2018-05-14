# frozen_string_literal: true

require 'sodor/x_lines'
require 'sodor/x_line'

module Sodor
  RSpec.describe XLines do
    subject(:x_lines) { described_class.new(lines) }

    let(:line_codes) { %w[AB1 BC2] }
    let(:lines) { line_codes.map { |line_code| XLine.new(line_code) } }

    describe '#routes' do
      context 'with non-existent origin and destination' do
        it { expect(x_lines.routes(Station.new(:X), Station.new(:Y))).to be_empty }
      end

      context 'with a single direct route' do
        it { expect(x_lines.routes(Station.new(:A), Station.new(:B))).to contain_exactly(%i[A B]) }
      end

      xcontext 'with a single hop route' do
        let(:line_codes) { %w[AB1 BC2 CD3] }

        xit do
          # expect(x_lines.routes(:A, :C)).to contain_exactly(%i[A B C])

          # Is origin directly connected to destination?
          # for each destination that is reachable from the origin
          #   check if that new origin is directly connected to destination?
          #     for each destination that is reachable from the new origin
          #       check if ...

          routes = x_lines.routes(:A, :C)

          ap routes

          binding.pry
          puts
        end
      end
    end

    describe '#routable?' do
      it { is_expected.to be_routable(:A, :C) }
      it { is_expected.not_to be_routable(:C, :B) }
    end

    describe '#origin?' do
      it { is_expected.to be_origin(:A) }
      it { is_expected.not_to be_origin(:C) }
    end

    describe '#destination?' do
      it { is_expected.to be_destination(:C) }
      it { is_expected.not_to be_destination(:A) }
    end

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

    describe '#origin_names' do
      subject { described_class.new(lines).origin_names }

      let(:origin_names) { lines.map(&:origin) }

      it { is_expected.to contain_exactly(*origin_names) }
    end

    describe '#destination_names' do
      subject { described_class.new(lines).destination_names }

      let(:destination_names) { lines.map(&:destination) }

      it { is_expected.to contain_exactly(*destination_names) }
    end
  end
end
