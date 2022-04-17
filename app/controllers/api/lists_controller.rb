class Api::ListsController < ApplicationController
  before_action :authenticate!, only: %i[create]

  def index
    list = List.all
    render json: list
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

  def list_params
    params.require(:list).permit(:title, :recommend, :playlistid)
  end
end
