require 'rails_helper'

describe DarkskyService do
  it "exists" do
    subject = DarkskyService.new(39.7392358,-104.990251)
    expect(subject).to be_a DarkskyService
  end

  context "#address_location" do
    it "returns forecast" do
      VCR.use_cassette('services/darksky_service') do
        subject = DarkskyService.new(39.7392358,-104.990251)
        weather_data = subject.weather_data
        expect(weather_data).to be_a Hash
        expect(weather_data).to have_key :current
        expect(weather_data).to have_key :hourly
        expect(weather_data).to have_key :daily
      end
    end
  end
end
