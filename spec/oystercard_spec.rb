require 'oystercard'

describe Oystercard do
  let(:subject) { Oystercard.new(30) }
  let(:station) { double :station }

  describe "#initialize" do

    it "oystercard shows balance" do
      expect(subject.balance).to eq 30
    end

    it "is initially not in a journey" do
      expect(subject).not_to be_in_journey
    end

    it "entry_station is nil upon purchasing the card" do
      expect(subject.entry_station).to eq nil
    end

    it "creates journey storage" do
      expect(subject.journeys_log).to be_instance_of JourneyLog
    end
  end
  
  describe "#top_up" do

    it "adds money to oystercard" do
      subject.top_up(5)
      expect(subject.balance).to eq 35
    end

    it "raises an error if limit is exceeded" do
      max_balance = Oystercard::DEFAULT_LIMIT
      expect { subject.top_up(max_balance) }.to raise_error "The limit of £#{max_balance} is exceeded."
    end
  end

  describe "#touch_in" do
    it "begins a journey" do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "raises an error if balance is less than the minimum fare" do
      oystercard = Oystercard.new
      expect { oystercard.touch_in(station) }.to raise_error "Insufficient funds"
    end

    it "stores the entry station" do
      subject.touch_in(station)
      expect(subject.journeys_log.journey_in_progress.entry_station).to eq station
    end

    it "charges penalty fare if the user didn't complete the previous journey" do
      subject.touch_in(station)
      subject.touch_in(station)
      expect(subject.balance).to eq 24
    end

  end

  describe "#touch_out" do
    before(:each) do
      subject.touch_in(station)
      allow(station). to receive(:zone).and_return(1)
    end

    it "stops a journey" do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "reduces balance by the amount of the fare" do
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-1)
    end

    it "forgets entry_station when touch out" do
      subject.touch_out(station)
      expect(subject.entry_station).to eq nil
    end

    it "saves a journey after touching out" do
      subject.touch_out(station)
      expect(subject.journeys_log.journeys.last).to be_instance_of Journey
    end
  end
end