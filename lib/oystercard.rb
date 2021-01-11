class Oystercard
attr_reader :balance
MAX_BALANCE = 90

  def initialize
    @balance = 0
    @active = false
  end

  def top_up(added)
    fail "Cannot top up by £#{added}. Balance already at £#{@balance}" if @balance + added > MAX_BALANCE
    @balance += added
  end

  def deduct(minus)
    @balance -= minus
  end

  def touch_in
    @active = true
    @active
  end

  def in_journey?
    @active
  end

  # def touch_out
  #
  # end
end
