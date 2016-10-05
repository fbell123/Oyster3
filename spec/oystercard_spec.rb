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

    it 'raises an error if the balance is too low' do
      oystercard.balance = 0
      expect { oystercard.touch_in(:station) }.to raise_error 'Balance is too low'
    end

  end


end
