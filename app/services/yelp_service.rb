class YelpService
  def initialize(location, arrival_time, cuisine)
    @location = location
    @arrival_time = arrival_time
    @cuisine = cuisine
  end

  def restaurant_options
    fetch_data
  end

  private

  def conn
    Faraday.new(url: "https://api.yelp.com/v3/businesses/search") do |f|
      f.adapter Faraday.default_adapter
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    # end
      f.params[:location] = @location
      f.params[:open_at] = @arrival_time
      f.params[:categories] = @cuisine
      f.params[:limit] = 3
    end
  end

  def fetch_data
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
#https://api.yelp.com/v3/businesses/search?location=pueblo,co&open_at=1564412184&categories=chinese&limit=3

# def get_json(url, params = {})
#       response = conn.get(url, params)
#       JSON.parse(response.body, symbolize_names: true)
# end

# def conn
#      Faraday.new(url: 'https://api.yelp.com') do |f|
#          f.adapter Faraday.default_adapter
#          f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}
#      end
# end
#
# def conn
#     Faraday.new('https://api.yelp.com', headers: {'Authorization' => "Bearer #{ENV['YELP_API_KEY']}"})
# end
