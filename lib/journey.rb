require_relative 'oystercard'

class Journey
  PENALTY_FARE = 3
  MIN_FARE = 1

  attr_reader :entry_station
  attr_accessor :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def current_journey?
    @exit_station == nil
  end

  def fare
    entry_station == "Penalty" || exit_station == "Penalty" ? PENALTY_FARE : MIN_FARE
  end


end
