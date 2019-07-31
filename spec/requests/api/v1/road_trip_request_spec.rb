require 'rails_helper'

describe "Road Trip API" do
  it "gets origin and destination and gives arrival time weather in destination area" do
    user = User.create!(email: 'test@test.com', password: 'swordfish', password_confirmation: 'swordfish')
    VCR.use_cassette('services/darksky_service3') do
      post '/api/v1/sessions?email=test@test.com&password=swordfish'

      expect(response).to be_successful

      post "/api/v1/road_trip?origin=Denver,CO&destination=Pueblo,CO&api_key=#{user.api_key}"

      expect(response).to be_successful
      forecast = JSON.parse(response.body)["data"]["attributes"]

      expect(forecast).to have_key("estimated_trip_time")
      expect(forecast["estimated_trip_time"]).to eq(6413)
      expect(forecast).to have_key("arrival_forecast")
      expect(forecast["arrival_forecast"]).to have_key("temp")
      expect(forecast["arrival_forecast"]).to have_key("summary")
      expect(forecast["arrival_forecast"]["temp"]).to eq(97.88)
      expect(forecast["arrival_forecast"]["summary"]).to eq("Clear")

    end
  end

  it "returns unauthorized when incorrect API is given" do
    user = User.create!(email: 'test@test.com', password: 'swordfish', password_confirmation: 'swordfish')
    VCR.use_cassette('services/darksky_service4') do
      post '/api/v1/sessions?email=test@test.com&password=swordfish'

      expect(response).to be_successful

      post "/api/v1/road_trip?origin=Denver,CO&destination=Pueblo,CO&api_key=WRONGKEY"

      expect(response).to have_http_status(401)
      forecast_fail = JSON.parse(response.body)

      expect(forecast_fail["error"]).to eq("API Key is missing or incorrect")
    end
  end
end
