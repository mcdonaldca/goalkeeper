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

		wdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
		months = [["Jan",31], ["Feb", 28], ["Mar", 31], ["Apr", 30], ["May", 31], ["Jun", 30], ["Jul", 31], ["Aug", 31], ["Sep", 30], ["Oct", 31], ["Nov", 30], ["Dec", 31]]

		wday = Time.now.wday - 1
		day = Time.now.day
		year = Time.now.year
		month = Time.now.month - 1

		@count = 28 * @goal.duration.to_i

		for current_iteration_number in 1..@count do
			wday = (wday + 1)%7
			if day == months[month][1]
				day = 1
				month = (month + 1)%12
				if month == 0
					year += 1
				end
			  if year%4 == 0 and month = 2
			  	day = 29
			  	month = 1
			  end
			elsif day == 29 and month == 1
				day = 1
				month = 2
			else
				day += 1
			end

		  atom = Atom.new
		  atom.goal = @goal
		  atom.day = day
		  atom.month = months[month][0]
		  atom.year = year

		  if @goal.frequency == "weekends" and (wday != 5 and wday != 6)
		  	atom.ignore = true

		  elsif @goal.frequency == "weekdays" and (wday == 5 or wday == 6)
		  	atom.ignore = true

		  elsif @goal.frequency != "everyday"
		  	if @goal.frequency.include? "M" and wday == 0
		  		atom.ignore = true
		  	end
		  	if @goal.frequency.include? "Tu" and wday == 1
		  		atom.ignore = true
		  	end
		  	if @goal.frequency.include? "W" and wday == 2
		  		atom.ignore = true
		  	end
		  	if @goal.frequency.include? "Th" and wday == 3
		  		atom.ignore = true
		  	end
		  	if @goal.frequency.include? "F" and wday == 4
		  		atom.ignore = true
		  	end
		  	if @goal.frequency.include? "Sa" and wday == 5
		  		atom.ignore = true
		  	end
		  	if @goal.frequency.include? "Su" and wday == 6
		  		atom.ignore = true
		  	end
		  end

		  atom.save
		end

		redirect_to goals_url
	end

	def destroy
    @goal = Goal.find params[:id]
    @goal.atoms.each do |atom|
    	atom.destroy
    end
    @goal.destroy
    redirect_to goals_url
  end

	def show
		@goal = Goal.find params[:id]
	end

	def atoms
		@goal = Goal.find params[:id]
		@atoms = @goal.atoms
	end
end
