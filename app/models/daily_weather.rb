class DailyWeather
  attr_reader :today_temperatureHigh, :today_temperatureLow, :weekly_forecast

  def initialize(daily_weather_info)
    @today_temperatureHigh = daily_weather_info.first[:temperatureHigh]
    @today_temperatureLow = daily_weather_info.first[:temperatureLow]
    @weekly_forecast = weekly_forecast(daily_weather_info)
  end

  def weekly_forecast(daily_weather_info)
    daily_weather_info[0...5].map do |day|
      { time: day[:time],
        icon: day[:icon],
        precipitation_chance: day[:precipProbability],
        highTemp: day[:temperatureHigh],
        lowTemp: day[:temperatureLow]
      }
    end
  end
end
