require_relative 'oystercard'

class Journey

  DEFAULT_PENALTY = 6
  MINIMUM_FARE = 1

  attr_reader :history, :clear_current_journey, :entry_station, :exit_station

  def initialize
    @history = []
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
    add_to_history
    fare
  end

  def add_to_history
    @history << self
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end

  def fare
    complete? ? MINIMUM_FARE : DEFAULT_PENALTY
  end

end
