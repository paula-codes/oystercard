require 'station'

describe Station do
  let(:subject) { Station.new("Test Name", 1) }

  describe "#initialize" do
    it "has a name attribute" do
      expect(subject.name).to eq "Test Name"
    end

    it "has a zone attribute" do
      expect(subject.zone).to eq 1
    end
  end
end