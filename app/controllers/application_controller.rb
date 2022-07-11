class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    render json: {
      code: 404,
      message: "The ID doesn't exist.",
      errors: "Not Found"
    }, :status => 404
  end

end
