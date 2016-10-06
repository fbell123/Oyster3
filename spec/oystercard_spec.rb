require 'oystercard'
require 'journey'
require 'station'

describe Oystercard do

  subject(:oystercard) {described_class.new}
  let(:station1){double("station", name: "Paddington", zone: 1)}
  let(:station2){double("station", name: "Waterloo", zone: 2)}
  let(:station3){double("station", name: "Bank", zone: 1)}
  let(:station4){double("station", name: "Kings", zone: 3)}

  describe "#initialize" do
    it 'has a balance of 50 by default' do
    expect(oystercard.balance).to eq 50
    end

    it "creates a journey log" do
      expect(oystercard.journey_log).not_to be nil
    end

  end

  describe "#top_up" do

    it 'increases balance by 40' do
      expect { oystercard.top_up(40)}.to change{oystercard.balance}.from(50).to(90)
    end

    it 'raises an error if the maximum balance is exceeded' do
      value = 100
      message = "Maximum balance exceeded"
      expect { oystercard.top_up(value) }.to raise_error message
    end

  end

  describe "#touch_in" do

    it 'raises an error if the balance is too low' do
      oystercard.balance = 0
      expect { oystercard.touch_in(:station1) }.to raise_error 'Balance is too low'
    end

    it 'charges penalty fare if you forgot to touch out' do
      expect{
        2.times{oystercard.touch_in(station1)}
      }.to change{oystercard.balance}.by(-Journey::DEFAULT_PENALTY)
    end

  end

  describe "#touch_out" do

    it 'charges penalty fare if you forgot to touch in' do
      expect{oystercard.touch_out(station2)}.to change{oystercard.balance}.by(-Journey::DEFAULT_PENALTY)
    end
  end

  it 'deducts boundary fare for one zone crossed' do
    expect{
      oystercard.touch_in(station1)
      oystercard.touch_out(station2)
    }.to change{oystercard.balance}.by(-((station1.zone - station2.zone).abs*Journey::BOUNDARY_FARE + Journey::MINIMUM_FARE))
  end

  it 'deducts positive amount when going back (i.e zone 3 to zone 1)' do
    expect{
      oystercard.touch_in(station4)
      oystercard.touch_out(station1)
    }.to change{oystercard.balance}.by(-((station4.zone - station1.zone).abs*Journey::BOUNDARY_FARE + Journey::MINIMUM_FARE))
  end


end
