class Api::VideosController < ApplicationController
  def index
    videos = Video.all
    render json: videos
  end

  def create
    videos = []
    list = List.find(params[:list][:id])
    params[:video].each do |item|
      video = {
        videoid: item[:snippet][:resourceId][:videoId],
        created_at: Time.current,
        updated_at: Time.current
      }
      videos << video
    end
    list.videos.insert_all(videos)
  end
end
