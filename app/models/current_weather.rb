class CurrentWeather
  attr_reader :temperature,
              :time,
              :summary,
              :summary_icon,
              :feels_like,
              :humidity,
              :visibility,
              :uv_index

  def initialize(current_weather_info)
    @temperature = current_weather_info[:temperature]
    @time = current_weather_info[:time]
    @summary = current_weather_info[:summary]
    @summary_icon = current_weather_info[:icon]
    @feels_like = current_weather_info[:apparentTemperature]
    @humidity = current_weather_info[:humidity]
    @visibility = current_weather_info[:visibility]
    @uv_index = "#{current_weather_info[:uvIndex]} (#{uv_rating(current_weather_info[:uvIndex])})"
  end

  def uv_rating(uv_index)
    if uv_index <= 2
      "low"
    elsif uv_index <= 5
      "medium"
    elsif uv_index <= 7
      "high"
    elsif uv_index <= 10
      "very high"
    else
      "extremely high"
    end
  end
end
