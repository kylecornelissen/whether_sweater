class WeatherFacade
  attr_reader :id

  def initialize(params)
    @params = params
    @id = 43
  end

  def location_info
    google_geo_service(@params[:location])
  end

  def weather_info
    latitude = location_info.location_coordinates[:lat]
    longitude = location_info.location_coordinates[:lng]
    darksky_service(latitude, longitude).weather_data
  end

  def current_weather
    { 'current temp' => weather_info[:current][:temperature],
      'today high' => weather_info[:daily][:data].first[:temperatureHigh],
      'today low' => weather_info[:daily][:data].first[:temperatureLow],
      'city' => location_info.location_address[:city],
      'state' => location_info.location_address[:state],
      'country' => location_info.location_address[:country],
      'current time date' => weather_info[:current][:time]
    }
  end

  def current_details
    { 'summary' => weather_info[:current][:summary],
      'summary_icon' => weather_info[:current][:icon],
      'feels like' => weather_info[:current][:apparentTemperature],
      'humidity' => weather_info[:current][:humidity],
      'visibility' => weather_info[:current][:visibility],
      'uv index' => weather_info[:current][:uvIndex],
      'today' => weather_info[:hourly][:summary]
    }
  end

  def hourly_weather
    # 
    {
    }
  end

  def daily_weather

  end

  private

  attr_reader :params

  def google_geo_service(location)
    GoogleGeoService.new(location)
  end

  def darksky_service(latitude, longitude)
    DarkskyService.new(latitude, longitude)
  end
end
