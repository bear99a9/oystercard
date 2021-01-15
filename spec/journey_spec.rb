require 'journey'
require 'station'

describe Journey do
  subject { described_class.new }
  let(:station) { Station.new("Mile End", 2) }
  let(:journey) { described_class.new(station) }
  let(:penalty) { described_class.new("Penalty")}

  context 'on initialization' do
    it 'returns entry station' do
      expect(journey.entry_station).to eq(station)
    end

    it 'exit station equals nil' do
      expect(journey.exit_station).to eq nil
    end
  end

  context 'normal completed journey' do

    it 'charges min fare' do
      journey.exit_station = "Bow"
      expect(journey.fare).to eq Journey::MIN_FARE
    end

    it 'returns exit station' do
      journey.exit_station = "Bow"
      expect(journey.exit_station).to eq "Bow"
    end
  end

  context 'Penalty fares' do

    it 'deducts penalty fare if touches in without touching out' do
      journey.exit_station = "Penalty"
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'deducts penalty fare if touches out without touching in' do
      expect(penalty.fare).to eq Journey::PENALTY_FARE
    end


  end
end
