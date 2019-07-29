class YelpService
  # def initialize(address)
  #   @address = address
  # end

  private

  def conn
    Faraday.new(url: "https://api.yelp.com/v3/businesses/search") do |f|
      f.adapter Faraday.default_adapter

    end
  end

  def fetch_data


  end
end
