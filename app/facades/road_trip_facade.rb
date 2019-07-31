class RoadTripFacade
  attr_reader :id

  def initialize(params)
    @params = params
  end

  def estimated_trip_time
    google_directions_service(@params[:origin], @params[:destination]).duration_time
  end

  def find_arrival_forecast
    coordinates = google_geo_service(@params[:destination]).location_coordinates
    hourly_weather = darksky_service(coordinates[:lat], coordinates[:lng]).weather_data[:hourly][:data]
    future_forecast = hourly_weather.min_by do |hour|
      (hour[:time]-trip_arrival_time).abs
    end
  end

  def arrival_forecast
    {
      temp: find_arrival_forecast[:temperature],
      summary: find_arrival_forecast[:summary]
    }
  end

  def trip_arrival_time
    current_time = Time.now.to_i
    estimated_trip_time
    current_time + estimated_trip_time
  end

  private

  def google_directions_service(origin, destination)
    GoogleDirectionsService.new(origin, destination)
  end

  def darksky_service(latitude, longitude)
    DarkskyService.new(latitude, longitude)
  end

  def google_geo_service(location)
    GoogleGeoService.new(location)
  end
end
