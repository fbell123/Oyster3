require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :entry_station, :last_journey, :current_journey, :exit_station
  attr_accessor :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = 50
    @last_journey = {}
    @entry_station = []
    @journey_history = []
    @current_journey = Journey.new(self)
  end

  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE  
    @entry_station << entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    deduct(@current_journey.fare)
    one_journey
  end

  def one_journey
    @last_journey = {entry_station: @entry_station, exit_station: @exit_station}
    journey_history
    @entry_station = nil
    @exit_station = nil
  end

  def journey_history
    @journey_history << @last_journey
  end


  def in_journey?
    @entry_station ? true : false
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
