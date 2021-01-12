class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @active = false
  end

  def top_up(added)
    fail "Cannot top up by £#{added}. Balance already at £#{@balance}" if @balance + added > MAX_BALANCE
    @balance += added
  end

  def touch_in
    fail "Insufficient funds for journey" if @balance < MIN_BALANCE
    @active = true
  end

  def in_journey?
    @active
  end

  def touch_out
    deduct(MIN_FARE)
    @active = false
  end

  private

  def deduct(minus)
    @balance -= minus
  end

end
