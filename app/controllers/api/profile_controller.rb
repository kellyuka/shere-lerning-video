class Api::ProfileController < ApplicationController
  before_action :authenticate!

  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      render json: user, methods: [:avatar_url]
    else
      render json: user.errors, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile, :channelid, :avatar)
  end
end
