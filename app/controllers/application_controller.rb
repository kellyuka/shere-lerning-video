class ApplicationController < ActionController::Base
  include Api::UserAuthenticator
  protect_from_forgery with: :null_session

  def not_authenticated
    redirect_to main_app.admin_login_path, notice: 'ログインしてください'
  end
end
