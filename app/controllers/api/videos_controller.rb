class Api::VideosController < ApplicationController
  def index
    videos = Video
    render json: videos
  end
end
