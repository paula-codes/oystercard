class Journey
  attr_reader :entry_station, :fare
  attr_accessor :exit_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = nil
  end

  def calculate_fare
   return @fare = PENALTY_FARE if invalid_journey?

   @fare = MINIMUM_FARE + zones_travelled
  end

  private
  def invalid_journey?
    @entry_station.nil? || @exit_station.nil?
  end

  def zones_travelled
    (entry_station.zone - exit_station.zone).abs
  end
end