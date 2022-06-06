class Api::UsersController < ApplicationController
  before_action :authenticate!, only: %i[me]

  def index
    user = User
    render json: user
  end

  def create
    user = User.new(user_params)

    if user.save
      token = user.create_tokens
      render json: { token: token }
    else
      render json: user.errors, status: :bad_request
    end
  end

  def me
    render json: current_user, methods: [:avatar_url]
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :channelid, :avatar, :profile)
  end
end
