class AtomsController < ApplicationController


	def success
	end

	def proof
		goal = Goal.find params[:id]
		note = params[:note]
		token = params[:token]

		months = [["Jan",31], ["Feb", 28], ["Mar", 31], ["Apr", 30], ["May", 31], ["Jun", 30], ["Jul", 31], ["Aug", 31], ["Sep", 30], ["Oct", 31], ["Nov", 30], ["Dec", 31]]
		
		curr_day = Time.now.day
		curr_month = Time.now.month - 1

		goal.atoms.each do |atom|
			if atom.day == curr_day and atom.month == months[curr_month][0]
				atom.proof = token
				atom.note = note
				atom.posted_at = Time.now
				atom.completed = true
				atom.success = true
				atom.save
			end
		end

		redirect_to :goals
	end

	def failure
	end

	def edit
	end
	
end
