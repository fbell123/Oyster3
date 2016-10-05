require_relative 'oystercard'

class Journey

  DEFAULT_PENALTY = 6
  MINIMUM_FARE = 1

  attr_reader :history_journey, :clear_current_journey, :current_journey

  def initialize
    @journey_history = []
  end

  def clear_current_journey
    @current_journey = {entry_station: nil, entry_zone: nil,
                     exit_station: nil, exit_zone: nil}
  end

  def start_journey(entry_station)
    clear_current_journey
    @current_journey[:entry_station] = entry_station.name
    @current_journey[:entry_zone] = entry_station.zone
  end

  def end_journey(exit_station)
    @current_journey[:exit_station] = exit_station.name
    @current_journey[:exit_zone] = exit_station.zone
    history_journey
  end

  def history_journey
    @journey_history << @current_journey
  end

  def fare
    if @current_journey[:entry_station] == nil
      DEFAULT_PENALTY
    elsif @current_journey[:exit_station] == nil
      DEFAULT_PENALTY
    else
      MINIMUM_FARE
    end
  end

end
