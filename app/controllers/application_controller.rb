class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from Pundit::NotAuthorizedError, with: :render_403
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_404
    render dtatus: :not_found, json: { message: 'record not found.' }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def pundit_user
    current_api_v1_user
  end

  def render_403
    render status: :forbidden, json: { message: "You don't have permission." }
  end
end
