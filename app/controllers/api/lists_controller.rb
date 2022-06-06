class Api::ListsController < ApplicationController
  before_action :currentuser_set_list, only: %i[update destroy]
  before_action :authenticate!, only: %i[create update destroy]
  include Pagy::Backend
  require 'pagy/extras/headers'

  def index
    pagy, lists = pagy(List.order(created_at: :desc))
    pagy_headers_merge(pagy)
    render json: lists
  end

  def show
    @list = List.find(params[:id])
    render json: @list
  end

  def create
    tag_ids = []
    videos = []
    params[:tag_names].each do |name|
      tag = Tag.find_or_create_by(name: name)
      tag_ids << tag.id
    end

    params[:videos].each do |item|
      video = {
        videoid: item[:snippet][:resourceId][:videoId],
        created_at: Time.current,
        updated_at: Time.current
      }
      videos << video
    end
    list = current_user.lists.build(list_params)
    list.tag_ids = tag_ids
    if list.save && list.videos.insert_all(videos)
      render json: list
    else
      render json: list.errors, status: :bad_request
    end
  end

  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :bad_request
    end
  end

  def destroy
    @list.destroy!
    render json: @list
  end

  private

  def currentuser_set_list
    @list = current_user.lists.find(params[:id])
  end

  def list_params
    # params.require(:list).permit(:title, :recommend, :playlistid, tag_ids: [])
    params.permit(:title, :recommend, :playlistid, tag_ids: [])
  end
end
