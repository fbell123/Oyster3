class Oystercard
  attr_reader :balance, :entry_station, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3

  def initialize
    @balance = 0
    @journey = {}
    @entry_station = []
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
    one_journey
    deduct(MINIMUM_FARE)
  end

  def one_journey
    @journey = {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
  end

  def in_journey?
    @entry_station ? true : false
  end

  private
  def deduct(value)
    @balance -= value
  end
end
