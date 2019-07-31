class FlickrService
  def initialize(location, weather)
    @location = location
    @weather = weather
  end

  def find_weather_background
    fetch_data("services/rest")[:photos][:photo].first
  end

  private

  def conn
    Faraday.new("https://api.flickr.com") do |f|
      f.adapter Faraday.default_adapter
      f.params[:api_key] = ENV['FLICKR_API_KEY']
    end
  end

  def fetch_data(url, filter = {})
    response = conn.get(url, optional_params.merge(filter))
    JSON.parse(response.body, symbolize_names: true)
  end

  def optional_params
    {
      method: 'flickr.photos.search',
      format: 'json',
      nojsoncallback: 1,
      safe_search: 1,
      sort: 'interestingness-desc',
      tags: "#{@weather}, #{@location}",
      is_getty: 'true'
    }
  end
end
