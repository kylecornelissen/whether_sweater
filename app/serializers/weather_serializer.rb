class WeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_weather, :hourly_weather, :daily_weather, :background_image
end
