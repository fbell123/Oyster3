require 'journey_log'
require 'journey'
require 'oystercard'
require 'station'

describe JourneyLog do

  subject(:journey_logger) {described_class.new}
  subject(:journey_history) {Journey.new}

  before :each do
    @station1 = Station.new('Paddington',1)
    @station2 = Station.new('Waterloo',2)
  end

  it "logs a list of all journeys" do

    expect(journey_logger.journey_history).to eq([{entry_station: "Paddington", entry_zone: 1,
                                    exit_station: "Waterloo", exit_zone: 2}])

  end

end
