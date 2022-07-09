class Api::FavoritesController < ApplicationController
  before_action :set_list, only: %i[create destroy]

  def index
    favorites = login_user.favorites_lists.order(created_at: :desc)
    render json: favorites, each_serializer: ListSerializer
  end

  def create
    login_user.favorite(@list)
    render json: @list, each_serializer: ListSerializer
  end

  def destroy
    login_user.unfavorite(@list)
    render json: @list
  end

  private

  def set_list
    @list = List.find(params[:id])
  end
end
