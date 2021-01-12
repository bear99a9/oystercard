require 'oystercard'

describe Oystercard do
  let(:topped_up_card) { Oystercard.new(Oystercard::MAX_BALANCE) }


  it 'should have a default balance' do
  expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  it 'has a balance of zero' do
    expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }


    it 'can top up the balance' do
      expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end

    it 'raises an error when maximum balance is exceeded' do
      topped_up_card
      expect{ topped_up_card.top_up(1) }.to raise_error "Cannot top up by £#{1}. Balance already at £#{Oystercard::MAX_BALANCE}"
    end
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  context "touch out" do
    it "can touch out" do
      topped_up_card.touch_in
      topped_up_card.touch_out
      expect(topped_up_card).not_to be_in_journey
    end

    it 'deducts money from balance' do
      topped_up_card.touch_in
      expect { topped_up_card.touch_out }.to change{ topped_up_card.balance}.by(-Oystercard::MIN_FARE)
    end
  end

  it "can touch in" do

    topped_up_card.touch_in
    expect(topped_up_card).to be_in_journey
  end

  context 'No credit on card' do
    it 'will not touch in if below minimum balance' do
      expect{ subject.touch_in }.to raise_error "Insufficient funds for journey"
    end
  end
end
