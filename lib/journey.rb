require_relative 'oystercard'

class Journey

  DEFAULT_PENALTY = 6
  MINIMUM_FARE = 1
  BOUNDARY_FARE = 1


  attr_reader :entry_station, :exit_station, :journey_log

  def initialize(journey_log)
    @journey_log = journey_log
  end

  def clear_current_journey
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(entry_station)
    clear_current_journey
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @entry_station = nil unless complete?
    add_to_history
    fare
  end



  def add_to_history
    @journey_log.save_journey(self)
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end

  def fare
    complete? ? boundary_fare : DEFAULT_PENALTY
  end

  def boundary_fare
    ((entry_station.zone - exit_station.zone).abs * BOUNDARY_FARE) + MINIMUM_FARE
  end

end
