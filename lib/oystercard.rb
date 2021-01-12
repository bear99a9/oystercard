class Oystercard
  attr_reader :balance, :entry_station, :journeys, :exit_station

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journeys = []
    @journey = { entrance_station: @entry_station, exit_station: @exit_station }
  end

  def top_up(added)
    fail "Cannot top up by £#{added}. Balance already at £#{@balance}" if @balance + added > MAX_BALANCE
    @balance += added
  end

  def touch_in(entry_station)
    fail "Insufficient funds for journey" if @balance < MIN_BALANCE
    @entry_station = entry_station
    @journey[:entrance_station] = @entry_station
  end

  def in_journey?
    !!entry_station #== nil ? false : true
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    @journey[:exit_station] = @exit_station
    @journeys << @journey
    @entry_station = nil
  end

  def entry_station
    @entry_station
  end

  def exit_station
    @exit_station
  end

  def journeys
    @journey
  end

  private

  def deduct(minus)
    @balance -= minus
  end

end

# array_1 = []
# array_to_hash = []
# array_1 << :mile_end
# array_1 << :ealing
# p array_to_hash << array_1
# p array_to_hash.to_h
# hash = {}
# hash.merge!(array_to_hash.to_h)
# p hash
