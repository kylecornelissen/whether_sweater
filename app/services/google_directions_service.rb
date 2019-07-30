class GoogleDirectionsService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def duration_time
    fetch_data[:routes].first[:legs].first[:duration][:value]
  end

  private

  def conn
    Faraday.new("https://maps.googleapis.com/maps/api/directions/json") do |f|
      f.adapter Faraday.default_adapter
      f.params[:origin] = @origin
      f.params[:destination] = @destination
      f.params[:key] = ENV['GOOGLE_API_KEY']
    end
  end

  def fetch_data
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end

#https://maps.googleapis.com/maps/api/directions/json?origin=Disneyland&destination=Universal+Studios+Hollywood&key=YOUR_API_KEY
