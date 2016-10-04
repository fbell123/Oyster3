require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :entry_station, :last_journey
  attr_accessor :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = 50
    @last_journey = {}
    @entry_station = []
  end

  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    one_journey
    deduct(MINIMUM_FARE)
  end

  def one_journey
    @last_journey = {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
    @exit_station = nil
  end


  def in_journey?
    @entry_station ? true : false
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
