require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :last_journey, :current_journey, :entry_station, :exit_station
  attr_accessor :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = 50
    clear_last_journey
    @journey_history = []
  end

  def clear_last_journey
    @last_journey = {entry_station: nil, entry_zone: nil,
                     exit_station: nil, exit_zone: nil}
  end

  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    clear_last_journey
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    @last_journey[:entry_station] = entry_station.name
    @last_journey[:entry_zone] = entry_station.zone
    [entry_station.name, entry_station.zone]
  end

  def touch_out(exit_station)
    @last_journey[:exit_station] = exit_station.name
    @last_journey[:exit_zone] = exit_station.zone
    journey_history
    self
  end

  def journey_history
    @journey_history << @last_journey
  end


  # def in_journey?
  #   @entry_station ? true : false
  # end

  private

  def deduct(fare)
    @balance -= fare
  end

end

card = Oystercard.new
station1 = Station.new("a",1)
station2 = Station.new("b",2)

puts card.touch_in(station1).inspect
puts card.touch_out(station2).inspect
puts card.touch_in(station2).inspect
puts card.touch_out(station1).inspect
