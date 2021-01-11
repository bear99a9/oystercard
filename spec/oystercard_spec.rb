require 'oystercard'

describe Oystercard do
  it 'has a default balance' do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it "allows you to top up balance" do
    expect{ subject.top_up 5 }.to change{ subject.balance}.by 5
  end

  # maximum balance in a constant variable and test will raise error when
  #balance over $90
  it 'raises an error when maximum balance is exceeded' do
    max = Oystercard::MAX_BALANCE
    subject.top_up(max)
    expect{ subject.top_up(1) }.to raise_error "Cannot top up by £#{1}. Balance already at £#{max}"
  end

  it { is_expected.to respond_to(:touch_in)}
  it ' when touched in, change in journey status' do
    expect{ subject.touch_in }.to change{ subject.in_journey? }.to true
  end


  it 'when not touched in journey returns false' do
    expect(subject).not_to be_in_journey
  end

  it "can touch in" do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  # it { is_expected.to respond_to(:touch_out)}

end
