require_relative 'oystercard'

class Journey

  DEFAULT_PENALTY = 6
  MINIMUM_FARE = 3

  def initialize(oyster)
    @oystercard = oyster
  end

  def start(oystercard)
    oystercard.entry_station ? true : false
  end

  def finish(oystercard)
    oystercard.exit_station ? true : false
  end

  def fare
    start(@oystercard) && finish(@oystercard) ? MINIMUM_FARE : DEFAULT_PENALTY
  end

end
