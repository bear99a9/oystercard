require 'station'
describe Station do

  subject {described_class.new("Mile End", 2)}

  it 'returns station name' do
    expect(subject.name).to eq("Mile End")
  end

  it 'returns station zone' do
    expect(subject.zone).to eq(2)
  end
end
