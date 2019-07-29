class Api::V1::MunchiesController < ApplicationController
  def index
    render json: MunchiesSerializer.new(MunchiesFacade.new(params))
  end
end
