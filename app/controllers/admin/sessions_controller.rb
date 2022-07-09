class Admin::SessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to rails_admin_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
