require 'rails_helper'

RSpec.describe DailyWeather, type: :model do
  before :each do
    VCR.use_cassette('services/darksky_service') do
      @weather_data = DarkskyService.new(39.7392358, -104.990251).weather_data
      @daily_weather = DailyWeather.new(@weather_data[:daily][:data])
    end
  end

  it 'initializes' do
    expect(@daily_weather.today_temperatureHigh).to eq(92.36)
    expect(@daily_weather.today_temperatureLow).to eq(68.16)
  end

  it '#weekly_forecast' do
    weekly_forecast = @daily_weather.weekly_forecast(@weather_data[:daily][:data])

    expect(weekly_forecast.count).to eq(5)
    expect(weekly_forecast.first[:time]).to eq(1564466400)
    expect(weekly_forecast.first[:icon]).to eq("fog")
    expect(weekly_forecast.first[:precipitation_chance]).to eq(0.08)
    expect(weekly_forecast.first[:highTemp]).to eq(92.36)
    expect(weekly_forecast.first[:lowTemp]).to eq(68.16)
  end
end
