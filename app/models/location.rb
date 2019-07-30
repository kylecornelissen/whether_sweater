class Location
  attr_reader :city, :state, :country

  def initialize(current_weather_info)
    @city = current_weather_info[:city]
    @state = current_weather_info[:state]
    @country = current_weather_info[:country]
  end
end
