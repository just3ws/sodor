# frozen_string_literal: true

require 'sodor/lines'
require 'sodor/line'
require 'sodor/line/line_set'
require 'sodor/line_code'

module Sodor
  RSpec.describe Lines do
    subject(:sodor_lines) { described_class.new(lines) }

    let(:lines) do
      foo = line_codes.map { |line_code| LineCode.new(line_code) }.map do |line_code|
        Line.new(Station.new(line_code.origin), Station.new(line_code.destination), line_code.distance)
      end

      Sodor::Line::LineSet.new(foo)
    end

    let(:line_codes) { %w[AB1 BC2] }

    describe '#routes' do
      context 'with non-existent origin and destination' do
        it { expect(sodor_lines.routes(Station.new(:X), Station.new(:B))).to be_empty }
        it { expect(sodor_lines.routes(Station.new(:A), Station.new(:Y))).to be_empty }
        it { expect(sodor_lines.routes(Station.new(:X), Station.new(:Y))).to be_empty }
      end

      context 'with a single direct route' do
        it do
          actual = sodor_lines.routes(Station.new(:A), Station.new(:B))
          expect(actual).to contain_exactly(%i[A B])
        end
      end

      context 'with a single hop route' do
        let(:line_codes) { %w[AB1 BC2 CD3] }
      end
    end

    describe '#routable?' do
      it { is_expected.to be_routable(Station.new(:A), Station.new(:C)) }
      it { is_expected.not_to be_routable(Station.new(:C), Station.new(:B)) }
    end

    describe '#origin' do
      it do
        expect(sodor_lines.origins_for(Station.new(:B))).to contain_exactly(Station.new(:A))
      end
    end

    describe '#origin?' do
      it { is_expected.to be_origin(Station.new(:A)) }
      it { is_expected.not_to be_origin(Station.new(:C)) }
    end

    describe '#destination?' do
      it { is_expected.to be_destination(Station.new(:C)) }
      it { is_expected.not_to be_destination(Station.new(:A)) }
    end

    describe '#destinations_for' do
      it do
        expect(sodor_lines.destinations_for(Station.new(:A))).to contain_exactly(Station.new(:B))
      end
    end

    describe '.build' do
      subject { described_class::Builder.build(sio) }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      it do
        ap subject
      end

      it { is_expected.to be_an_instance_of(Lines) }
      it { is_expected.to contain_exactly(*lines) }
    end
  end
end
