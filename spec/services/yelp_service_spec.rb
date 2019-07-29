require 'rails_helper'

describe YelpService do
  it "exists" do
    subject = YelpService.new("denver,co")
    expect(subject).to be_a YelpService
  end

  context "#restaurant_options" do
    it "returns three restaurants that meet criteria" do
      VCR.use_cassette("yelp_service") do
        subject = YelpService.new("pueblo,co", 1564412184, "chinese")
        restaurants = subject.restaurant_options
        expect(restaurants).to be_a Hash
        # expect(address_coordinates).to have_key :lat
        # expect(address_coordinates).to have_key :lng
        # expect(address_coordinates[:lat]).to be_a Float
        # expect(address_coordinates[:lng]).to be_a Float
      end
    end
  end
end
