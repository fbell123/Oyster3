require 'journey_log'
require 'journey'
require 'oystercard'
require 'station'

describe JourneyLog do

  subject(:journey_log) {described_class.new}
  subject(:journey) {double("journey")}
  subject(:journey2) {double("journey")}
  subject(:journey3) {double("journey")}
  let(:station1){double("station", name: "Paddington", zone: 1)}
  let(:station2){double("station", name: "Waterloo", zone: 2)}

  it 'checks journey history is empty when the log is created' do
    expect(journey_log.history).to eq []
  end

  it 'checks a journey is saved' do
    journey_log.save_journey(journey)
    expect(journey_log.history.last).to be journey
  end

  it "logs a list of all journeys" do
    journey_log.save_journey(journey)
    journey_log.save_journey(journey2)
    journey_log.save_journey(journey3)
    expect(journey_log.history).to eq [journey, journey2, journey3]
  end

end
