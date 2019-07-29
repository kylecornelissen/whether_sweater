class GoogleGeoService
  def initialize(address)
    @address = address
  end

  def address_coordinates
    # fetch_data("/congress/v1/members/house/#{state}/current.json")
    # require "pry"; binding.pry
    fetch_data[:results].first[:geometry][:location]
  end

  private

  def conn
    Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json") do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GOOGLE_API_KEY']
      f.params[:address] = @address
    end
  end

  def fetch_data
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
