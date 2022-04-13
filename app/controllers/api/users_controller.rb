class Api::UsersController < ApplicationController
  before_action :authenticate!, only: %i[me]

  def index
    user = User.all
    render json: user
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def me
    render json: current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
