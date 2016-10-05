require 'journey'
require 'oystercard'
require 'station'

describe Journey do

  subject(:journey_history) {described_class.new}

  before :each do
    @station1 = Station.new('Paddington',1)
    @station2 = Station.new('Waterloo',2)
  end

  describe "#fare" do
    it "deducts the minimum fare for a single trip" do
      journey_history.start_journey(@station1)
      journey_history.end_journey(@station2)
      expect(journey_history.fare).to eq Journey::MINIMUM_FARE
    end

    it 'deducts the penalty fare for incomplete journey' do
      journey_history.start_journey(@station1)
      expect(journey_history.fare).to eq Journey::DEFAULT_PENALTY
    end

  end

  it "last journey hash has the appropriate key symbols" do
    expect(journey_history.clear_current_journey).to include(:entry_station, :entry_zone,
                                                      :exit_station, :exit_zone)
  end

  it 'checks if one journey is created on touch out' do
    journey_history.start_journey(@station1)
    journey_history.end_journey(@station2)
    expect(journey_history.current_journey).to eq({entry_station: "Paddington", entry_zone: 1,
                                    exit_station: "Waterloo", exit_zone: 2})
  end

  it 'checks the default journey history' do
    expect(journey_history.clear_current_journey).to eq({entry_station: nil, entry_zone: nil,
                                                        exit_station: nil, exit_zone: nil})
  end

  it 'records entry station name and zone' do
    journey_history.start_journey(@station1)
    expect(journey_history.current_journey).to eq({entry_station: "Paddington", entry_zone: 1, exit_station: nil, exit_zone: nil})
  end

end
