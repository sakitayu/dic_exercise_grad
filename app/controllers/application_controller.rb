class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  
  def after_sign_in_path_for(resource)
    start_users_path # ログイン後に遷移するpath
  end

  # def after_sign_out_path_for(resource)
  #   new_user_session_path # ログアウト後に遷移するpath
  # end

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :name, :gender, :age, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
