require_relative 'oystercard'

class Journey

  DEFAULT_PENALTY = 6
  MINIMUM_FARE = 3

  def initialize
    @journey_history = []
    @recent_journey = {}
  end

  def start(oystercard)
    oystercard.touch_in ? true :false
  end

  def finish(oystercard)
    oystercard.touch_out ? true : false
  end

  def fare
    start && finish ? MINIMUM_FARE : DEFAULT_PENALTY
  end

  def recent_journey(oystercard)
    @recent_journey = oystercard.last_journey
  end

  def journey_history
    @journey_history << @recent_journey
  end


end
