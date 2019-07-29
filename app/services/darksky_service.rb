class DarkskyService
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def weather_data
    { 'current': fetch_data[:currently],
      'hourly': fetch_data[:hourly],
      'daily': fetch_data[:daily]
    }
  end

  private

  def conn
    Faraday.new("https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/#{@latitude},#{@longitude}") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def fetch_data
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
