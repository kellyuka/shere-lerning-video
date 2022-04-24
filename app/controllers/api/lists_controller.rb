class Api::ListsController < ApplicationController
  before_action :authenticate!, only: %i[create]
  before_action :set_list, only: %i[show]

  def index
    lists = List.all
    render json: lists, include: [:videos]
  end

  def show
    render json: @list, include: [:videos]
  end

  def create
    list = current_user.lists.build(list_params)
    if list.save
      render json: list
    else
      render json: list.errors, status: :bad_request
    end
  end

  private
  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:title, :recommend, :playlistid)
  end
end
