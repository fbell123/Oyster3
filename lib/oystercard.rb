class Oystercard
  attr_reader :balance, :entry_station, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3

  def initialize
    @balance = 0
    @entry_station = []
    @journey = []
  end

  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    @entry_station << station
    @journey << station
  end

  def touch_out(station)
    @journey << station
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @entry_station ? true : false
  end

  private
  def deduct(value)
    @balance -= value
  end
end
