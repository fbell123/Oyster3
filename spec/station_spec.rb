require 'station'

describe Station do

  before do
    @station = Station.new(:name, :zone)
  end

  it 'gives station a name' do
    expect(@station.name).to eq :name
  end

  it 'gives station a zone' do
    expect(@station.zone).to eq :zone
  end

end
