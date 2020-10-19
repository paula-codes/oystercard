class Oystercard
  attr_reader :balance
  DEFAULT_LIMIT = 90

  def initialize 
    @balance = 0
  end
  
  def top_up(value)
    fail "The limit of £90 is exceeded." if value + balance > DEFAULT_LIMIT
    @balance += value
  end
end