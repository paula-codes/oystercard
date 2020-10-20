require 'journey'

describe Journey do
  let(:station) { double :station }

  describe "#initialize" do
    let(:subject) { Journey.new(station) }
    
    it "has an entry station" do
      expect(subject.entry_station).to eq station
    end

    it "has an exit station" do
      expect(subject.exit_station).to eq nil
    end

    it "has a fare" do
      expect(subject.fare).to eq nil
    end
  end

  describe "#calculate_fare" do
    let (:station2) {double :station2}
    before(:each) do 
      allow(station). to receive(:zone).and_return(1)
    end

    it "returns a minimum fare" do
      journey = Journey.new(station, station)
      journey.calculate_fare
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "sets a penalty fare if no entry station" do
      journey = Journey.new(nil, station)
      journey.calculate_fare
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "sets a penalty fare if no exit station" do
      journey = Journey.new(station, nil)
      journey.calculate_fare
      expect(journey.fare). to eq Journey::PENALTY_FARE
    end

    it "calculates the fare if travelled in the same zone" do
      journey = Journey.new(station, station2)
      allow(station2). to receive(:zone).and_return(1)
      journey.calculate_fare
      expect(journey.fare). to eq Journey::MINIMUM_FARE
    end

    it "calculates the fare if travelled between zones" do
      journey = Journey.new(station, station2)
      allow(station2). to receive(:zone).and_return(2)
      journey.calculate_fare
      expect(journey.fare). to eq 2
    end
  end
end