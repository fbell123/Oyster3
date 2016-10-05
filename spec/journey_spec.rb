require 'journey'
require 'oystercard'
require 'station'

describe Journey do

  subject(:journey_history) {described_class.new}

  before :each do

  end

  describe "#fare" do
    it "deducts the minimum fare for a single trip" do
      station1 = Station.new('Paddington',1)
      station2 = Station.new('Waterloo',2)
      journey_history.start_journey(station1)
      journey_history.end_journey(station2)
      expect(journey_history.fare).to eq Journey::MINIMUM_FARE
    end

    it 'deducts the penalty fare for incomplete journey' do

    end

  end

end
