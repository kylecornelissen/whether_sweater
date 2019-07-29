class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :end_city, :restaurants
end
