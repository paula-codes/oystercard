require 'oystercard'

describe Oystercard do

  describe "#balance" do
    it "oystercard shows balance" do 
      card = Oystercard.new
      expect(subject.balance).to eq 0
    end
  end
end