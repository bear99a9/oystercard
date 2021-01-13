require 'oystercard'

describe Oystercard do
  let(:topped_up_card) { Oystercard.new(Oystercard::MAX_BALANCE) }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }


    it 'can top up the balance' do
      expect{ subject.top_up Oystercard::MIN_BALANCE }.to change{ subject.balance }.by Oystercard::MIN_BALANCE
    end

    it 'raises an error when maximum balance is exceeded' do
      topped_up_card
      expect{ topped_up_card.top_up(Oystercard::MIN_BALANCE) }.to raise_error "Cannot top up by £#{Oystercard::MIN_BALANCE}. Balance already at £#{Oystercard::MAX_BALANCE}"
    end
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  context "touch out" do
    it "can touch out" do
      topped_up_card.touch_in(entry_station)
      topped_up_card.touch_out(exit_station)
      expect(topped_up_card).not_to be_in_journey
    end

    it 'deducts money from balance' do
      topped_up_card.touch_in(entry_station)
      expect { topped_up_card.touch_out(exit_station) }.to change{ topped_up_card.balance}.by(-Oystercard::MIN_FARE)
    end

    it 'wipes entry station variable' do
      topped_up_card.touch_in(entry_station)
      expect { topped_up_card.touch_out(exit_station) }.to change{ topped_up_card.entry_station}.to(nil)
    end

    it "touch_out method to store exit station" do
      topped_up_card.touch_in(entry_station)
      topped_up_card.touch_out(exit_station)
      expect(topped_up_card.exit_station).to eq exit_station
    end

  end

  it "can touch in" do
    topped_up_card.touch_in(entry_station)
    expect(topped_up_card).to be_in_journey
  end

  it "touch_in method to store entry station" do
    topped_up_card.touch_in(entry_station)
    expect(topped_up_card.entry_station).to eq entry_station
  end

  context 'No credit on card' do
    it 'will not touch in if below minimum balance' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds for journey"
    end
  end

  it 'has an empty list of journeys by default' do
    card = Oystercard.new
    expect(card.journeys).to be_empty
  end

  it 'stores the journey' do
    topped_up_card.touch_in(entry_station)
    topped_up_card.touch_out(exit_station)
    expect(topped_up_card.journeys).to include(journey)
  end

end
