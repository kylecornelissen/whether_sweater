class GoogleGeoService
  def initialize(location)
    @location = location
  end

  def location_coordinates
    fetch_data[:results].first[:geometry][:location]
  end

  def location_address
    address_components = fetch_data[:results].first[:address_components]
    {
      city: address_components.first[:long_name],
      state: address_components[2][:short_name],
      country: address_components[3][:long_name]
    }
  end

  private

  def conn
    Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json") do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GOOGLE_API_KEY']
      f.params[:address] = @location
    end
  end

  def fetch_data
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
