class Api::TagsController < ApplicationController
  def index
    tags = Tag.all
    render json: tags
  end

  def create
    tag = Tag.build(tag_params)
    if tag.save
      render tag
    else
      render json: tag.errors, status: :bad_request
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
