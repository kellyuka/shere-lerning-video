class Api::FavoritesController < ApplicationController
  before_action :set_list, only: %i[create destroy]

  def index
    favorites = current_user.favorites_lists
    render json: favorites, include: %i[user videos tags comments]
  end

  def create
    current_user.favorite(@list)
    render json: @list, include: %i[user videos tags comments]
  end

  def destroy
    current_user.unfavorite(@list)
    render json: @list
  end

  private

  def set_list
    @list = List.find(params[:id])
  end
end
