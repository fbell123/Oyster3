require 'journey'
require 'oystercard'
require 'station'

describe Journey do

  let(:journey_log) {double("journey log", save_journey: true)}
  subject(:journey) {described_class.new(journey_log)}
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

  it 'knows which journey log to log to' do
    expect(journey).to respond_to(:journey_log)
  end

  it 'saves journey to journey log' do
    expect(journey_log).to receive(:save_journey)
    journey.end_journey(station2)
  end

end
