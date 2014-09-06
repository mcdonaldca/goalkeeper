class GkController < ApplicationController
	before_filter :get_logged_in_user, :except => [:index]
  
  def index
  end

  def feed
  end  

  def ziggeo
  end

end
