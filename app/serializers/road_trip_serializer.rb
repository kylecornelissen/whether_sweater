class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :estimated_trip_time, :arrival_forecast
end
