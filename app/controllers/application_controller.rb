class ApplicationController < ActionController::Base
	protect_from_forgery

  private

  def get_logged_in_user
    id = session[:user_id]
    if id.nil?
      flash[:notice] = "You must log in first"
      redirect_to login_url
    else
      @user = User.find id
    end
  end
end
