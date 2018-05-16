# frozen_string_literal: true

require 'sodor/lines'
require 'sodor/line'
require 'sodor/line/set'
require 'sodor/line_code'

module Sodor
  RSpec.describe Lines do
    subject(:lines) { described_class.new(line_set) }

    let(:line_set) do
      Sodor::Line::Set.new(
        line_codes
        .map { |line_code| Sodor::LineCode.new(line_code) }
        .map { |line_code| Sodor::Line.new(Sodor::Station.new(line_code.origin), Sodor::Station.new(line_code.destination), line_code.distance) }
      )
    end

    let(:line_codes) { %w[AB1 BC2] }

    describe '#routable?' do
      it { is_expected.to be_routable(Station.new(:A), Station.new(:C)) }
      it { is_expected.not_to be_routable(Station.new(:C), Station.new(:B)) }
    end

    describe '#origin' do
      it do
        expect(lines.origins_for(Station.new(:B))).to contain_exactly(Station.new(:A))
      end
    end

    describe '#origin?' do
      it { is_expected.to be_origin(Sodor::Station.new(:A)) }
      it { is_expected.not_to be_origin(Sodor::Station.new(:C)) }
    end

    describe '#destination?' do
      it { is_expected.to be_destination(Sodor::Station.new(:C)) }
      it { is_expected.not_to be_destination(Sodor::Station.new(:A)) }
    end

    describe '#destinations_for' do
      it { expect(lines.destinations_for(Sodor::Station.new(:A))).to contain_exactly(Sodor::Station.new(:B)) }
    end

    describe '.build' do
      subject { Sodor::LinesBuilder.build(sio) }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      it { is_expected.to be_an_instance_of(Lines) }
      it { is_expected.to contain_exactly(*line_set) }
    end
  end
end
