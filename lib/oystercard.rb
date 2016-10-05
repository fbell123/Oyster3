require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :current_journey, :entry_station, :exit_station
  attr_accessor :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = 50
    @journey = Journey.new
  end


  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    @journey.start_journey(entry_station)
    [entry_station.name, entry_station.zone]
  end

  def touch_out(exit_station)
    @journey.end_journey(exit_station)
    deduct(@journey.fare)
    [exit_station.name, exit_station.zone, @journey.fare]
  end


  private

  def deduct(fare)
    @balance -= fare
  end

end
