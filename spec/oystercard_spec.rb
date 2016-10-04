require 'oystercard'
require 'journey'

describe Oystercard do

  it 'has a balance of 50 by default' do
  expect(subject.balance).to eq 50
  end

  it 'has a balance that can be topped up' do
    expect(subject.top_up(40)).to eq subject.balance
  end

  it 'raises an error if the maximum balance is exceeded' do
    value = 100
    message = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(value + subject.balance)-Oystercard::MAXIMUM_BALANCE}"
    expect { subject.top_up(value) }.to raise_error message
  end

  it 'has a balance that can be reduced' do
    subject.top_up(40)
    expect(subject.touch_out(:station)).to eq subject.balance
  end

  context 'with balance' do
    let (:station) {double :station}

    before :example do
      subject.top_up(20)

    end
    it 'touched in at the start of a journey' do
      subject.touch_in(:station)
      expect(subject.in_journey?).to be true
    end

    it 'records the entry station' do
      subject.touch_in(:station)
      expect(subject.entry_station).to eq :station
    end

    it 'decreases balance by the minimum fare on touching out' do
    expect {subject.touch_out(:station)}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it 'checks the default journey history' do
      expect(subject.last_journey).to be_empty
    end

    it 'checks if one journey is created on touch out' do
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.last_journey).to include(:entry_station, :exit_station)
    end
  end

  it 'records the end of a journey' do
    subject.touch_out(:station)
    expect(subject.in_journey?).to be false
  end

  it 'raises an error if the balance is too low' do
    subject.balance = 0
    expect { subject.touch_in(:station) }.to raise_error 'Balance is too low'
  end

end
