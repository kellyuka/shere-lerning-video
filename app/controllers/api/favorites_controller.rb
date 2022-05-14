class Api::FavoritesController < ApplicationController
  before_action :set_list, only: %i[create destroy]

  def index
    favorites = current_user.favorites_lists.order(created_at: :desc)
    render json: favorites,
           only: %i[id user_id title recommend],
           include: [
             { videos: { only: :videoid } },
             { comments: { only: [] } },
             { tags: { only: %i[id name] } },
             { user: { methods: :avatar_url,
                       only: :name } }
           ]
  end

  def create
    current_user.favorite(@list)
    render json: @list,
           only: %i[id user_id title recommend],
           include: [
             { videos: { only: :videoid } },
             { comments: { only: [] } },
             { tags: { only: %i[id name] } },
             { user: { methods: :avatar_url,
                       only: :name } }
           ]
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
