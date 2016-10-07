require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :journey, :journey_log
  attr_accessor :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = 50
    @journey_log = JourneyLog.new
  end

  def top_up(value)
    raise "Maximum balance exceeded" if @balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    #If the user forgot to touch out, touch out with a station of nil
    #aka you have a journey and an exit station but no entry station
    touch_out(nil) if !@journey.nil? && @journey.exit_station.nil?
    create_journey(entry_station)
    entry_message
  end

  def touch_out(exit_station)
    #If this is the first ever touch
    #touch_in(nil) if @journey.nil? && journey.entry_station.nil?
    create_journey(nil) if @journey.nil? || @journey_log.history.include?(@journey)
    deduct(@journey.end_journey(exit_station))
    exit_message
  end


  private

  def deduct(fare)
    @balance -= fare
  end

  def create_journey(entry_station)
    @journey = Journey.new(@journey_log)
    @journey.start_journey(entry_station)
  end

  def entry_message
    puts "Station: #{@journey.entry_station.name}"
  end

  def exit_message
    puts "Station: #{@journey.exit_station.name}. Charge: #{@journey.fare}" unless @journey.exit_station.nil?
    penalty_message
  end

  def penalty_message
    puts "Charged penalty fare #{Journey::DEFAULT_PENALTY}" unless @journey.complete?
  end

end
