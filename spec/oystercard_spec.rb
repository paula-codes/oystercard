require 'oystercard'

describe Oystercard do

  describe "#balance" do
    it "oystercard shows balance" do 
      card = Oystercard.new
      expect(subject.balance).to eq 0
    end
  end
  
  describe "#top_up" do
    it "adds money to oystercard" do
      card = Oystercard.new
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end
  end
end