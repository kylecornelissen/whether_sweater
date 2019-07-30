class HourlyWeather
  attr_reader :today_info, :hourly_forecast

  def initialize(hourly_weather_info)
    @today_info = hourly_weather_info[:summary]
    @hourly_forecast = hourly_forecast(hourly_weather_info[:data])
  end

  def hourly_forecast(hourly_weather_info_data)
    hourly_weather_info_data[0...8].map do |hour|
      { time: hour[:time],
        temp: hour[:temperature],
        icon: hour[:icon]
      }
    end
  end
end
