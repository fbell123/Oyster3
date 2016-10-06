require_relative 'station'
require_relative 'journey'

class JourneyLog

  attr_reader :history

  def initialize
    @history = []
  end

  def save_journey(journey)
    @history << journey
  end

end
