class Api::ListsController < ApplicationController
  before_action :authenticate!, only: %i[create]
  before_action :set_list, only: %i[show]
  before_action :currentuser_set_list, only: %i[update destroy]

  def index
    lists = List.all
    render json: lists, include: %i[videos tags  comments]
  end

  def show
    render json: @list, include: [:videos]
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

  def userlists
    user = User.find(current_user.id)
    lists = user.lists
    render json: lists, include: %i[videos tags]
  end

  def aboutlists
    lists = List.all.limit(3)
    render json: lists, include: %i[videos]
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def currentuser_set_list
    @list = current_user.lists.find(params[:id])
  end

  def list_params
    # params.require(:list).permit(:title, :recommend, :playlistid, tag_ids: [])
    params.permit(:title, :recommend, :playlistid, tag_ids: [])
  end
end
