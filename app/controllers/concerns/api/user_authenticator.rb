module Api::UserAuthenticator
  extend ActiveSupport::Concern

  def authenticate!
    return if login_user

    head :unauthorized
  end

  def login_user
    return @login_user if @login_user
    return unless bearer_token

    payload, = User.decode bearer_token
    @login_user ||= User.find_by(id: payload['user_id'])
  rescue JWT::ExpiredSignature
    nil
  end

  def bearer_token
    pattern = /^Bearer /
    header = request.headers['Authorization']
    header.gsub(pattern, '') if header&.match(pattern)
  end
end
