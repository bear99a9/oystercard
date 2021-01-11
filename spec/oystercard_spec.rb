require 'oystercard'

describe Oystercard do
  it 'has a default balance' do
    expect(subject.balance).to eq 0
  end


  context "changing balance" do
    # before (:example) do
    #   subject.top_up(Oystercard::MAX_BALANCE)
    # end
    it "allows you to top up balance" do
      expect{ subject.top_up 5 }.to change{ subject.balance}.by 5 #Oystercard::MAX_BALANCE
    end

    it 'raises an error when maximum balance is exceeded' do
      max = Oystercard::MAX_BALANCE
      subject.top_up(max)
      expect{ subject.top_up(1) }.to raise_error "Cannot top up by £#{1}. Balance already at £#{max}"
    end

    it "allows you to deduct from balance" do
      expect{ subject.deduct 5 }.to change{ subject.balance}.by -5 
    end

  end 


  # it { is_expected.to respond_to(:touch_in)}
  # it ' when touched in, change in journey status' do
  #   expect{ subject.touch_in }.to change{ subject.in_journey? }.to true
  # end


  it 'when not touched in journey returns false' do
    expect(subject).not_to be_in_journey
  end

  it "can touch in" do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it "can touch in" do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end
