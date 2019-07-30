require 'rails_helper'

RSpec.describe Location, type: :model do
  before :each do
    VCR.use_cassette('services/google_geo_service') do
      location_data = GoogleGeoService.new("denver,co").location_address
      @location = Location.new(location_data)
    end
  end

  it 'initializes' do
    expect(@location.city).to eq("Denver")
    expect(@location.state).to eq("CO")
    expect(@location.country).to eq("United States")
  end
end
