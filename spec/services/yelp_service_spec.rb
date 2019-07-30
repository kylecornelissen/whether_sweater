require 'rails_helper'

describe YelpService do
  it "exists" do
    subject = YelpService.new("denver,co", 1564412184, "chinese")
    expect(subject).to be_a YelpService
  end

  context "#restaurant_options" do
    it "returns three restaurants that meet criteria" do
      VCR.use_cassette('services/yelp_service') do
        subject = YelpService.new("denver,co", 1564412184, "chinese")
        restaurants = subject.restaurant_options
        expect(restaurants).to be_a Hash
        expect(restaurants).to have_key :businesses
        expect(restaurants[:businesses].count).to eq(3)
      end
    end
  end
end
