require 'journey'
require 'oystercard'
require 'station'

describe Journey do

  subject(:journey) {described_class.new}
  let(:station1){double("station", name: "Paddington", zone: 1)}
  let(:station2){double("station", name: "Waterloo", zone: 2)}

  describe "#fare" do
    it "deducts the minimum fare for a single trip" do
      journey.start_journey(station1)
      journey.end_journey(station2)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it 'deducts the penalty fare for incomplete journey' do
      journey.start_journey(station1)
      expect(journey.fare).to eq Journey::DEFAULT_PENALTY
    end

    it 'deducts penatly if haven\'t touched in' do
      journey.end_journey(station1)
      expect(journey.fare).to eq Journey::DEFAULT_PENALTY
    end

  end

  it 'checks if start journey saves entry station' do
    journey.start_journey(station1)
    expect(journey.entry_station).to be station1
  end

  it 'checks if end journey saves exit station' do
    journey.end_journey(station2)
    expect(journey.exit_station).to be station2
  end

  it 'checks a journey is saved' do
    journey.start_journey(station1)
    journey.end_journey(station2)
    expect(journey.history.last).not_to be_nil
  end

  it 'checks journey history is empty when Oyster is created' do
    expect(journey.history).to eq []
  end



end
