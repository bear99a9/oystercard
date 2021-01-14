require 'journey'

describe Journey do
  subject { described_class.new }
  let(:complete_journey) { double entry_station: "Mile End", exit_station: "Bank" }

  it 'returns entry station' do
    expect(complete_journey.entry_station).to eq "Mile End"
  end

  it 'returns exit station' do
    expect(complete_journey.exit_station).to eq "Bank"
  end


end
