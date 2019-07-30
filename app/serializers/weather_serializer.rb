class WeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_weather, :current_details, :hourly_weather, :daily_weather
end
