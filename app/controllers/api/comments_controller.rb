class Api::CommentsController < ApplicationController
  before_action :authenticate!, only: %i[create]
  before_action :currentuser_set_comment, only: %i[update destroy]
  def index
    comments = Comment
    render json: comments
  end

  def show
    list = List.find(params[:id])
    comments = list.comments
    render json: comments,
           include: [
             { user:
               { methods: :avatar_url,
                 only: :name } }
           ]
  end

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      render json: comment,
             include: [
               { user:
                 { methods: :avatar_url,
                   only: :name } }
             ]
    else
      render json: comment.errors, status: :bad_request
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment,
             include: [
               { user:
                 { methods: :avatar_url,
                   only: :name } }
             ]
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
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :list_id)
  end
end
