class Api::V1::RoadTripController < ApplicationController
  def create
    api_key = User.find_by(api_key: params[:api_key])
    if api_key
      render json: RoadTripSerializer.new(RoadTripFacade.new(params))
    else
      render json: { error: "API Key is missing or incorrect" }, status: 401
    end
  end
end
