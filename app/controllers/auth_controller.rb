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
        redirect_to venmo_url
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

  def venmo
    if session[:user_id] == nil
      flash[:notice] = "You need to login first"
      redirect_to login_url
    end
  end

  def authorization
    # Only access if user is logged in
    if !params[:access_token].nil?
      @token = params[:access_token]
      uri = URI.parse("https://api.venmo.com/v1/me?access_token=" + params[:access_token])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request).body
      user_info = JSON.parse(response)["data"]["user"]
      @access_token = params[:access_token]
      @username = user_info["username"]      
    end
    redirect_to feed_url
  end

end
