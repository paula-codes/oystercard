require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  attr_reader :balance, :entry_station, :journeys_log
  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @journeys_log = JourneyLog.new
  end
  
  def top_up(value)
    new_balance = balance + value
    fail "The limit of £#{DEFAULT_LIMIT} is exceeded." if new_balance > DEFAULT_LIMIT
    @balance = new_balance
  end 

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    touch_out(nil) if journeys_log.journey_in_progress != nil
    journeys_log.start(station)
  end

  def touch_out(station)
    journeys_log.finish(station)
    journeys_log.journeys.last.calculate_fare
    deduct(journeys_log.journeys.last.fare)
  end

  def in_journey?
    !journeys_log.journey_in_progress.nil?
  end

  private
  def deduct(fare)
    @balance -= fare
  end
end