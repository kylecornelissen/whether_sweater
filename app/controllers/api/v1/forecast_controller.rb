class Api::V1::ForecastController < ApplicationController
  def index
    render json: WeatherSerializer.new(WeatherFacade.new(params))
  end
end
