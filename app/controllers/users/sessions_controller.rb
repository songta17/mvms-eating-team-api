# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  respond_to :json

  private
  
  def respond_with(resource, _opts = {})
    @user = User.find_by(email: resource.email.downcase)
    if @user.present? && sign_in(@user)
      render json: { 
        code: 200, # ok
        message: 'Logged Successfully.' 
      }, status: 200
    else
      render json: { 
        code: 401, # Unauthorized
        message: 'Unauthorized'
      }, status: 401
    end
  end
  
  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end
  
  def log_out_success
    render json: { 
      code: 202, #accepted
      message: "Logged out successfully." 
      }, status: 202 
  end
  
  def log_out_failure
    render json: { 
      code: 401, # Unauthorized
      message: "Logged out failure.",
      errors: "Unauthorized"
    }, status: :unauthorized
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   # super
  #   # render json: "hello world"
  #   self.resource = resource_class.new(sign_in_params)
  #   clean_up_passwords(resource)
  #   yield resource if block_given?
  #   respond_with(resource, serialize_options(resource))
  #   render json: "ok"
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
