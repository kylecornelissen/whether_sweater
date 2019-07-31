require 'rails_helper'

describe "Forecast API" do
  it "gets location and gives weather forecast" do
    VCR.use_cassette('services/darksky_service2') do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful
      forecast = JSON.parse(response.body)["data"]["attributes"]

      expect(forecast).to have_key("current_weather")
      expect(forecast["current_weather"]).to have_key("temperature")
      expect(forecast["current_weather"]).to have_key("time")
      expect(forecast["current_weather"]).to have_key("summary")
      expect(forecast["current_weather"]).to have_key("summary_icon")
      expect(forecast["current_weather"]).to have_key("feels_like")
      expect(forecast["current_weather"]).to have_key("humidity")
      expect(forecast["current_weather"]).to have_key("visibility")
      expect(forecast["current_weather"]).to have_key("uv_index")
      expect(forecast).to have_key("hourly_weather")
      expect(forecast["hourly_weather"]["hourly_forecast"].count).to eq(8)
      expect(forecast["hourly_weather"]["hourly_forecast"].first).to have_key("time")
      expect(forecast["hourly_weather"]["hourly_forecast"].first).to have_key("temp")
      expect(forecast["hourly_weather"]["hourly_forecast"].first).to have_key("icon")
      expect(forecast).to have_key("daily_weather")
      expect(forecast["daily_weather"]["weekly_forecast"].count).to eq(5)
      expect(forecast["daily_weather"]["weekly_forecast"].first).to have_key("time")
      expect(forecast["daily_weather"]["weekly_forecast"].first).to have_key("icon")
      expect(forecast["daily_weather"]["weekly_forecast"].first).to have_key("precipitation_chance")
      expect(forecast["daily_weather"]["weekly_forecast"].first).to have_key("highTemp")
      expect(forecast["daily_weather"]["weekly_forecast"].first).to have_key("lowTemp")
      expect(forecast).to have_key("background_image")
      expect(forecast["background_image"]).to have_key("id")
      expect(forecast["background_image"]).to have_key("owner")
    end
  end
end
