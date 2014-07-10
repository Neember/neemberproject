class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
    unless current_user.is_admin?
      redirect_to root_path, alert: 'You are not allowed to visit this page'
    end
  end

  def home

  end

  def after_signin_path_for(resource)
    root_path
  end
end
