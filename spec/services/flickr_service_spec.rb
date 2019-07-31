require 'rails_helper'

describe FlickrService do
  it "exists" do
    subject = FlickrService.new("denver,co", "snow")
    expect(subject).to be_a FlickrService
  end

  context "#find_weather_background" do
    it "returns photos" do
      VCR.use_cassette('services/flickr_service') do
        subject = FlickrService.new("denver,co", "snow")
        weather_background = subject.find_weather_background
        expect(weather_background).to be_a Hash
        expect(weather_background).to have_key :id
        expect(weather_background).to have_key :owner
        expect(weather_background).to have_key :title
      end
    end
  end

end
