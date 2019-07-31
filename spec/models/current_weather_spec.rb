require 'rails_helper'

RSpec.describe CurrentWeather, type: :model do
  before :each do
    VCR.use_cassette('services/darksky_service') do
      weather_data = DarkskyService.new(39.7392358, -104.990251).weather_data
      @current_weather = CurrentWeather.new(weather_data[:current])
    end
  end

  it 'initializes' do
    expect(@current_weather.temperature).to eq(90.23)
    expect(@current_weather.time).to eq(1564521021)
    expect(@current_weather.summary).to eq("Foggy")
    expect(@current_weather.summary_icon).to eq("fog")
    expect(@current_weather.feels_like).to eq(90.23)
    expect(@current_weather.humidity).to eq(0.22)
    expect(@current_weather.visibility).to eq(1.139)
    expect(@current_weather.uv_index).to eq("6 (high)")
  end

  it '#uv_rating' do
    low_rating = @current_weather.uv_rating(1)
    med_rating = @current_weather.uv_rating(4)
    high_rating = @current_weather.uv_rating(6)
    very_high_rating = @current_weather.uv_rating(9)
    ex_high_rating = @current_weather.uv_rating(11)

    expect(low_rating).to eq("low")
    expect(med_rating).to eq("medium")
    expect(high_rating).to eq("high")
    expect(very_high_rating).to eq("very high")
    expect(ex_high_rating).to eq("extremely high")
  end
end
