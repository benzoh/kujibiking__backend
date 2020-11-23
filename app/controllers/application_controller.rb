class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # skip_before_action :verify_authenticity_token
  # skip_before_action :verify_authenticity_token, if: :devise_controller? # APIではCSRFチェックをしない

  # raise
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render status: 404, json: { message: "record not found." }
  end
end
