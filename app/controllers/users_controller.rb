class UsersController < ApplicationController

	before_filter :get_logged_in_user, :except => [:new, :create]

	def index
		@users = User.all
	end

	def new
    @user = User.new
  end

  def create
	  @user = User.new(params[:user])
	 
    if @user.save
    	session[:user_id] = @user.id
      redirect_to venmo_url
    else
      render action: 'new'
    end
	  
	end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to users_url
  end

end
