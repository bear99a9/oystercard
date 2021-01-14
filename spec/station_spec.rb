require 'station'
describe Station do

  subject(:station ) {described_class.new(name: "Mile End", zone: 2)}

  it 'returns station name' do
    expect(station.name).to eq("Mile End")
  end

  it 'returns station zone' do
    expect(station.zone).to eq(2)
  end
end
