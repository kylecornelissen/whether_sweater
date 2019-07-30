require 'rails_helper'

describe GoogleGeoService do
  it "exists" do
    subject = GoogleGeoService.new("denver,co")
    expect(subject).to be_a GoogleGeoService
  end

  context "#address_location" do
    it "returns latitude and longitude" do
      VCR.use_cassette("google_geo_service") do
        subject = GoogleGeoService.new("denver,co")
        address_coordinates = subject.address_coordinates
        expect(address_coordinates).to be_a Hash
        expect(address_coordinates).to have_key :lat
        expect(address_coordinates).to have_key :lng
        expect(address_coordinates[:lat]).to be_a Float
        expect(address_coordinates[:lng]).to be_a Float
      end
    end
  end
end
