class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def require_user_logged_in
    unless current_user
      redirect_to root_url
    end
  end
  
end
