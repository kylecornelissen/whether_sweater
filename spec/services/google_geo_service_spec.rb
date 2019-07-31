require 'rails_helper'

describe GoogleGeoService do
  it "exists" do
    subject = GoogleGeoService.new("denver,co")
    expect(subject).to be_a GoogleGeoService
  end

  context "#location_coordinates" do
    it "returns latitude and longitude" do
      VCR.use_cassette('services/google_geo_service') do
        subject = GoogleGeoService.new("denver,co")
        location_coordinates = subject.location_coordinates
        expect(location_coordinates).to be_a Hash
        expect(location_coordinates).to have_key :lat
        expect(location_coordinates).to have_key :lng
        expect(location_coordinates[:lat]).to be_a Float
        expect(location_coordinates[:lng]).to be_a Float
      end
    end
  end

  context "#location_address" do
    it "returns latitude and longitude" do
      VCR.use_cassette('services/google_geo_service') do
        subject = GoogleGeoService.new("denver,co")
        location_address = subject.location_address
        expect(location_address).to be_a Hash
        expect(location_address).to have_key :city
        expect(location_address).to have_key :state
        expect(location_address).to have_key :country
        expect(location_address[:city]).to be_a String
        expect(location_address[:state]).to be_a String
        expect(location_address[:country]).to be_a String
      end
    end
  end
end
