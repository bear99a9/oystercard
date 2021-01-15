require_relative 'Journey'
require_relative 'Station'

class Oystercard
  attr_reader :balance, :current_journey, :list_of_journeys

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @list_of_journeys = []
    @current_journey = nil
    # @journey = { entry_station: @entry_station, exit_station: @exit_station }
  end

  def top_up(added)
    fail "Cannot top up by £#{added}. Balance already at £#{@balance}" if @balance + added > MAX_BALANCE
    @balance += added
  end

  def touch_in(entry_station)
    fail "Insufficient funds for journey" if @balance < MIN_BALANCE
    in_journey?
    penalty_touch_in if in_journey?
    @current_journey = Journey.new(entry_station)
    return "Touched in at #{entry_station}"
  end


  def touch_out(exit_station)
    penalty_touch_out unless in_journey?
    @current_journey.exit_station = exit_station
    @list_of_journeys << @current_journey
    deduct(@current_journey.fare)
    @current_journey = nil
    in_journey?
    return "Touched out at #{exit_station}"
  end

  def in_journey?
    !!@current_journey
  end


  private

  def deduct(minus)
    @balance -= minus
  end
  def penalty_touch_in
    @current_journey.exit_station = "Penalty"
    @current_journey = nil
    puts "£#{Journey::PENALTY_FARE} penalty charge for not touching out"
  end

  def penalty_touch_out
    @current_journey = Journey.new("Penalty")
    puts "£#{Journey::PENALTY_FARE} penalty charge for not touching in"
  end
end
