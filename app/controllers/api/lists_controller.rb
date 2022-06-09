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
    @list = ListForm.new(list_params)
    if @list.valid?
      @list.save
      render json: @list.to_model, each_serializer: ListSerializer
    else
      render json: @list.errors, status: :bad_request
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
    params.require(:list).permit(:title, :recommend, :playlistid, videos:[], list_tags:[]).merge(user_id: current_user.id)
  end
end
