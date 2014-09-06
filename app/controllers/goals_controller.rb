class GoalsController < ApplicationController

	def index
		@goals = Goal.all
	end

	def new
    @goal = Goal.new
  end

	def commitment
		@goal = Goal.new
		@goal.charity = params[:goal][:charity]
		@goal.action = 'tbd'
		@goal.duration = '1'
		@goal.frequency = 'every'
	 
    if !@goal.save
      render action: 'new'
    end
	end

	def action
		duration = params[:duration]
		frequency = ''
		if params[:SU] != nil
			frequency += params[:SU]
		elsif params[:M] != nil
			frequency += params[:M]
		end
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
	end

	def create
	end

	def destroy
    @goal = Goal.find params[:id]
    @goal.destroy
    redirect_to goals_url
  end

	def show
	end
end
