class WeatherFacade
  attr_reader :id

  def initialize(params)
    @params = params
  end

  def location_info
    Location.new(google_geo_service(@params[:location]).location_address)
  end

  def weather_info
    location = google_geo_service(@params[:location])
    latitude = location.location_coordinates[:lat]
    longitude = location.location_coordinates[:lng]
    darksky_service(latitude, longitude).weather_data
  end

  def current_weather
    CurrentWeather.new(weather_info[:current])
  end

  def hourly_weather
    # gives upcoming 8 hours
    HourlyWeather.new(weather_info[:hourly])
  end

  def daily_weather
    DailyWeather.new(weather_info[:daily][:data])
  end

  private

  def google_geo_service(location)
    GoogleGeoService.new(location)
  end

  def darksky_service(latitude, longitude)
    DarkskyService.new(latitude, longitude)
  end
end
