require_relative 'station'
require_relative 'journey'

class JourneyLog

  def initialize(journey)
    @journey_log = Array.new
    @journey_log << journey
  end

end
