class Api::CommentsController < ApplicationController
  before_action :authenticate!, only: %i[create]
  before_action :currentuser_set_comment, only: %i[update destroy]

  def show
    list = List.find(params[:id])
    comments = list.comments
    render json: comments
  end

  def create
    comment = login_user.comments.build(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors, status: :bad_request
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :bad_request
    end
  end

  def destroy
    @comment.destroy!
    render json: @comment
  end

  private

  def currentuser_set_comment
    @comment = login_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :list_id)
  end
end
