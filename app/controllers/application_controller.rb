class ApplicationController < ActionController::API

  def authenticate!
    raise Pundit::NotAuthorizedError, "Not authenticated!" unless authenticated?
  end

  def authenticated?
    request.headers["x-authentication-token"] == Rails.application.credentials.dig(:token) || params[:token] == Rails.application.credentials.dig(:public_token)
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    render json: { error: exception.message }
  end


end
