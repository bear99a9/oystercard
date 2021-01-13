require 'oystercard'

describe Oystercard do
  subject { described_class.new }
  let(:topped_up_card) { Oystercard.new(Oystercard::MAX_BALANCE) }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  context 'on initialization the card' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }


    it 'can top up the balance' do
      expect{ subject.top_up Oystercard::MIN_BALANCE }.to change{ subject.balance }.by Oystercard::MIN_BALANCE
    end

    context 'when maximum balance is exceeded' do
      it 'raises an error' do
        topped_up_card
        expect{ topped_up_card.top_up(Oystercard::MIN_BALANCE) }.to raise_error "Cannot top up by £#{Oystercard::MIN_BALANCE}. Balance already at £#{Oystercard::MAX_BALANCE}"
      end
    end
  end

  describe 'journey' do
    context 'If card has insufficient funds to touch in' do
      it 'it raises an error' do
        expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds for journey"
      end
    end

    context 'topped up card' do
      it "can touch in" do
        topped_up_card.touch_in(entry_station)
        expect(topped_up_card).to be_in_journey
      end

      it "touch_in can store entry station" do
        topped_up_card.touch_in(entry_station)
        expect(topped_up_card.entry_station).to eq entry_station
      end
    end

    context "touch out" do
      it "card can touch out" do
        topped_up_card.touch_in(entry_station)
        topped_up_card.touch_out(exit_station)
        expect(topped_up_card).not_to be_in_journey
      end

      it 'deducts money from balance' do
        topped_up_card.touch_in(entry_station)
        expect { topped_up_card.touch_out(exit_station) }.to change{ topped_up_card.balance}.by(-Oystercard::MIN_FARE)
      end

      it "touch_out method to store exit station" do
        topped_up_card.touch_in(entry_station)
        topped_up_card.touch_out(exit_station)
        expect(topped_up_card.exit_station).to eq exit_station
      end

      it 'wipes entry station variable' do
        topped_up_card.touch_in(entry_station)
        expect { topped_up_card.touch_out(exit_station) }.to change{ topped_up_card.entry_station}.to(nil)
      end

      it 'stores the journey' do
        topped_up_card.touch_in(entry_station)
        topped_up_card.touch_out(exit_station)
        expect(topped_up_card.journeys).to include(journey)
      end
    end
  end

end
