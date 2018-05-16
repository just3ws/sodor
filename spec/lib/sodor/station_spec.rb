# frozen_string_literal: true

require 'sodor/station'

module Sodor
  RSpec.describe Station do
    subject(:station) { described_class.new(:A) }

    it 'has a code' do
      expect(station.code).to equal(:A)
    end

    it 'compares instances by their code' do
      s1 = Station.new(:A)
      s2 = Station.new(:A)

      expect(s1).to eq(s2)
    end
  end
end
