require 'rails_helper'

RSpec.describe HourlyWeather, type: :model do
  before :each do
    VCR.use_cassette('services/darksky_service') do
      @weather_data = DarkskyService.new(39.7392358, -104.990251).weather_data
      @hourly_weather = HourlyWeather.new(@weather_data[:hourly])
    end
  end

  it 'initializes' do
    expect(@hourly_weather.today_info).to eq("Foggy later this afternoon.")
  end

  it '#hourly_forecast' do
    hourly_forecast = @hourly_weather.hourly_forecast(@weather_data[:hourly][:data])

    expect(hourly_forecast.count).to eq(8)
    expect(hourly_forecast.first[:time]).to eq(1564513200)
    expect(hourly_forecast.first[:temp]).to eq(90.59)
    expect(hourly_forecast.first[:icon]).to eq("partly-cloudy-day")
  end
end
