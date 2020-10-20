require_relative 'journey'

class JourneyLog
  attr_reader :journey_class, :journeys, :journey_in_progress

  def initialize
    @journey_class = Journey
    @journeys = []
    @journey_in_progress = nil
  end

  def start(entry_station)
    journey = journey_class.new(entry_station)
    @journey_in_progress = journey
  end

  def finish(exit_station)
    journey = current_journey
    journey.exit_station = exit_station
    journeys << journey 
    @journey_in_progress = nil
  end

  private
  def current_journey
    @journey_in_progress || journey_class.new(nil)
  end
end