class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(UsersFacade.new(user)), status: 200
    else
      render json: { error: 'Your email or password is invalid' }
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: 'User has logged out' }
  end
end
