class Api::CommentsController < ApplicationController
  before_action :authenticate!, only: %i[create]

  def index
    comments = Comment.all
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

  private

  def comment_params
    params.require(:comment).permit(:body, :list_id)
  end
end
