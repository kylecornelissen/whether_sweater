class MunchiesFacade
  attr_reader :id

  def initialize(params)
    @params = params
    @id = 42
  end

  def end_city
    @params[:end]
  end

  def arrival_time
    current_time = Time.now.to_i
    duration_time = google_directions_service(@params[:start], @params[:end]).duration_time
    arrival_time = current_time + duration_time
  end

  def find_restaurants
    restaurants = yelp_service(end_city, arrival_time, @params[:food]).restaurant_options[:businesses]
  end

  def restaurants
    find_restaurants.map do |restaurant|
      {restaurant[:name] => restaurant[:location]}
    end
  end

  private

  attr_reader :params

  def google_directions_service(origin, destination)
    GoogleDirectionsService.new(origin, destination)
  end

  def yelp_service(location, arrival_time, cuisine)
    YelpService.new(location, arrival_time, cuisine)
  end

end
