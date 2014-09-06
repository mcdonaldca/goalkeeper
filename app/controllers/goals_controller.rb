class GoalsController < ApplicationController

	before_filter :get_logged_in_user

	def index
		user = User.find session[:user_id]
		@goals = user.goals
	end

	def new
    @goal = Goal.new
  end

	def commitment
		@goal = Goal.new
		@goal.user = User.find session[:user_id]
		@goal.charity = params[:goal][:charity]
		@goal.action = 'tbd'
		@goal.duration = '1'
		@goal.frequency = 'everyday'
	 
    if !@goal.save
      render action: 'new'
    end
	end

	def action
		duration = params[:duration]
		@disp = params
		frequency = ''
		if params[:SUN] == "1"
			frequency += "Su"
		end
		if params[:MON] == "1"
			frequency += "M"
		end
		if params[:TUE] == "1"
			frequency += "Tu"
		end
		if params[:WED] == "1"
			frequency += "W"
		end
		if params[:THU] == "1"
			frequency += "Th"
		end
		if params[:FRI] == "1"
			frequency += "F"
		end
		if params[:SAT] == "1"
			frequency += "Sa"
		end

		#@disp = frequency
		#frequency = params[:SU] + params[:M] + params[:TU] + params[:W] + params[:TH] + params[:F] + params[:SA]

		if frequency == "MTuWThF"
			frequency = "weekdays"
		elsif frequency == "SaSu"
			frequency = "weekends"
		elsif frequency == "SuMTuWThFSa"
			frequency = "everyday"
		end

		@goal = Goal.find params[:id]
		@goal.duration = duration
		@goal.frequency = frequency
		@goal.save
	end

	def create
		action = params[:goal_action]

		@goal = Goal.find params[:id]
		@goal.action = action
		@goal.save

		redirect_to goals_url
	end

	def destroy
    @goal = Goal.find params[:id]
    @goal.destroy
    redirect_to goals_url
  end

	def show
	end
end
