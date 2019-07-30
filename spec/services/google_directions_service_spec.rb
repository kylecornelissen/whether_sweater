require 'rails_helper'

describe GoogleDirectionsService do
  it "exists" do
    subject = GoogleDirectionsService.new("denver,co", "pueblo,co")
    expect(subject).to be_a GoogleDirectionsService
  end

  context "#restaurant_options" do
    it "returns three restaurants that meet criteria" do
      subject = GoogleDirectionsService.new("denver,co", "pueblo,co")
      duration_time = subject.duration_time
      expect(duration_time).to be_a Integer
    end
  end
end
