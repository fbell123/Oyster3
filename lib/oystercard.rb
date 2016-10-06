require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :journey
  attr_accessor :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = 50
  end

  def top_up(value)
    raise "Maximum balance exceeded" if @balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    touch_out(nil) if !@journey.nil? && @journey.exit_station.nil?
    create_journey(entry_station)
    [@journey.entry_station]
  end

  def touch_out(exit_station)
    create_journey(nil) if @journey.nil?
    deduct(@journey.end_journey(exit_station))
    [@journey.exit_station, @journey.fare]
  end


  private

  def deduct(fare)
    @balance -= fare
  end

  def create_journey(entry_station)
    @journey = Journey.new
    @journey.start_journey(entry_station)
  end

end
