require 'oystercard'
require 'journey'
require 'station'

describe Oystercard do

  subject(:oystercard) {described_class.new}

  before(:each) do
    @station1 = double(:station)
    @station2 = double(:station)
    allow(@station1).to receive(:name).and_return('Paddington')
    allow(@station1).to receive(:zone).and_return(1)
    allow(@station2).to receive(:name).and_return('Euston Square')
    allow(@station2).to receive(:zone).and_return(2)
  end

  describe "#initialize" do
    it 'has a balance of 50 by default' do
    expect(oystercard.balance).to eq 50
    end

    it 'checks the default journey history' do
      expect(oystercard.journey_history).to eq([{entry_station: nil, entry_zone: nil,
                                            exit_station: nil, exit_zone: nil}])
    end

  end

  describe "#top_up" do

    it 'increases balance by 40' do
      expect { oystercard.top_up(40)}.to change{oystercard.balance}.from(50).to(90)
    end

    it 'raises an error if the maximum balance is exceeded' do
      value = 100
      message = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(value + oystercard.balance)-Oystercard::MAXIMUM_BALANCE}"
      expect { oystercard.top_up(value) }.to raise_error message
    end

  end

  describe "#touch_in" do

    it 'records entry station name and zone' do
      oystercard.touch_in(@station1)
      expect(oystercard.last_journey).to eq({entry_station: "Paddington", entry_zone: 1, exit_station: nil, exit_zone: nil})
    end

    it 'raises an error if the balance is too low' do
      oystercard.balance = 0
      expect { oystercard.touch_in(:station) }.to raise_error 'Balance is too low'
    end

  end


  it "last journey hash has the appropriate key symbols" do
    expect(oystercard.last_journey).to include(:entry_station, :entry_zone,
                                              :exit_station, :exit_zone)
  end



    it 'checks if one journey is created on touch out' do
      oystercard.touch_in(@station1)
      oystercard.touch_out(@station2)
      expect(oystercard.last_journey).not_to be_empty
    end




end
