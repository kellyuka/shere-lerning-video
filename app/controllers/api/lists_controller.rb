class Api::ListsController < ApplicationController
  before_action :authenticate!, only: %i[create]
  before_action :set_list, only: %i[show]
  before_action :currentuser_set_list, only: %i[update destroy]

  def index
    lists = List.all.order(created_at: :desc)
    render json: lists,
           only: %i[id user_id title recommend],
           include: [
             { videos: { only: :videoid } },
             { comments: { only: [] } },
             { tags: { only: %i[id name] } },
             { user: { methods: :avatar_url,
                       only: :name } }
           ]
  end

  def show
    render json: @list,
           only: %i[id user_id playlistid title recommend],
           include: [
             { videos: { only: %i[id videoid] } },
             { tags: { only: %i[id name] } },
             { user: { methods: :avatar_url,
                       only: %i[name profile] } }
           ]
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
      render json: list,
             only: %i[id user_id title recommend],
             include: [
               { videos: { only: %i[id videoid] } },
               { comments: { only: [] } },
               { tags: { only: %i[id name] } },
               { user: { methods: :avatar_url,
                         only: %i[name profile] } }
             ]
    else
      render json: list.errors, status: :bad_request
    end
  end

  def update
    if @list.update(list_params)
      render json: @list,
             only: %i[id user_id title recommend],
             include: [
               { videos: { only: %i[id videoid] } },
               { comments: { only: [] } },
               { tags: { only: %i[id name] } },
               { user: { methods: :avatar_url,
                         only: %i[name profile] } }
             ]
    else
      render json: @list.errors, status: :bad_request
    end
  end

  def destroy
    @list.destroy!
    render json: @list
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
