class ApplicationController < ActionController::API

  def authenticate!
    raise Pundit::NotAuthorizedError, "Not authenticated!" unless request.headers["x-authentication-token"] == Rails.application.credentials.dig(:token)
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    render json: { error: exception.message }
  end


end
