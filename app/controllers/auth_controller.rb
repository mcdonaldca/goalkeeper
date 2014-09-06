class AuthController < ApplicationController
  
  def login
  end

  def do_login
    email_from_form = params[:email]
    password_from_form = params[:password]
    @user = User.find_by_email(email_from_form)
    if (@user.nil?)
      flash[:notice] = "Unknown User"
      redirect_to login_url
    else
      if (@user.password == password_from_form)
        # User successfully logged in
        session[:user_id] = @user.id
        redirect_to feed_url
      else
        flash[:notice] = "Incorrect Password"
        redirect_to login_url
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to index_url
  end
end
