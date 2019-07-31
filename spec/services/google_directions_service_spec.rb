require 'rails_helper'

describe GoogleDirectionsService do
  it "exists" do
    subject = GoogleDirectionsService.new("denver,co", "pueblo,co")
    expect(subject).to be_a GoogleDirectionsService
  end

  context "#duration_time" do
    it "returns duration time of trip" do
      VCR.use_cassette('services/google_directions_service') do
        subject = GoogleDirectionsService.new("denver,co", "pueblo,co")
        duration_time = subject.duration_time
        expect(duration_time).to be_a Integer
      end
    end
  end
end
