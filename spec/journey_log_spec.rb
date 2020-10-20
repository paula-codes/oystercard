require 'journey_log'

describe JourneyLog do
  let(:station) { double :station }

  describe "#initialize" do
    it "has a journey_class that can make journeys" do
      expect(subject.journey_class).to eq Journey
    end

    it "has an empty journeys array" do 
      expect(subject.journeys).to eq []
    end
  end

  describe "#start" do
    before(:each) { subject.start(station) }
    it "creates a new journey and stores it in journey_in_progress" do
      expect(subject.journey_in_progress).to be_instance_of Journey
    end

    it "starts a new journey with an entry station" do
      expect(subject.journey_in_progress.entry_station).to eq station
    end
  end

  describe "#finish" do
    before(:each) do
      subject.start(station)
      subject.finish(station)  
    end
    
    it "should add an exit station to the completed journey" do
      expect(subject.journeys.last.exit_station).to eq station
    end

    it "should set journey_in_progress back to nil" do
      expect(subject.journey_in_progress).to be_nil
    end
  end
end