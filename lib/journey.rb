class Journey

  attr_reader :entry_station
  attr_accessor :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def in_journey?
    !!entry_station #if nil the first ! turns it into false,
    # the second bang turns it into true see below if statement
    #entry_station == nil ? false : true
  end
  
end
