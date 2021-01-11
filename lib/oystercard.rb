class Oystercard
attr_reader :balance
MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(added)
    fail "card full, #{@balance} already in balance" if @balance + added > MAX_BALANCE
    @balance = added
  end

end
