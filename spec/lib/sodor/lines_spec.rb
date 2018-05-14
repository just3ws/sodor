# frozen_string_literal: true

require 'sodor/lines'
require 'sodor/line'

module Sodor
  RSpec.describe Lines do
    subject { described_class.new(lines) }

    let(:line_codes) { %w[AB1 BC2] }
    let(:lines) { line_codes.map { |line_code| Line.new(line_code) } }

    describe '#routes' do
      context 'with non-existent origin and destination' do
        it { expect(subject.routes(Station.new(:X), Station.new(:B))).to be_empty }
        it { expect(subject.routes(Station.new(:A), Station.new(:Y))).to be_empty }
        it { expect(subject.routes(Station.new(:X), Station.new(:Y))).to be_empty }
      end

      xcontext 'with a single direct route' do
        xit { expect(lines.routes(Station.new(:A), Station.new(:B))).to contain_exactly(%i[A B]) }
      end

      xcontext 'with a single hop route' do
        let(:line_codes) { %w[AB1 BC2 CD3] }

        xit do
          # expect(lines.routes(:A, :C)).to contain_exactly(%i[A B C])

          # Is origin directly connected to destination?
          # for each destination that is reachable from the origin
          #   check if that new origin is directly connected to destination?
          #     for each destination that is reachable from the new origin
          #       check if ...

          # foo = lines.routes(:A, :C)

          # ap foo
          #
          root = :A

          binding.pry
          puts
        end
      end
    end

    describe '#routable?' do
      it { is_expected.to be_routable(Station.new(:A), Station.new(:C)) }
      it { is_expected.not_to be_routable(Station.new(:C), Station.new(:B)) }
    end

    describe '#origin' do
      it do
        expect(subject.origins_for(Station.new(:B))).to contain_exactly(Station.new(:A))
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
        expect(subject.destinations_for(Station.new(:A))).to contain_exactly(Station.new(:B))
      end
    end

    describe '.build' do
      subject { described_class.build(sio) }

      let(:sio) do
        StringIO.new.tap do |io|
          line_codes.each { |line_code| io.puts(line_code) }
          io.rewind
        end
      end

      it { is_expected.to be_an_instance_of(Lines) }
      it { is_expected.to contain_exactly(*lines) }
    end
  end
end
