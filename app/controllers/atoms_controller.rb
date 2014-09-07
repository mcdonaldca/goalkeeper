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

	def submit_url
		response = Net::HTTP.post_form(URI.parse('https://api.venmo.com/v1/payments'), {'user_id' => person.id, 'amount' => (5).to_s, 'note' => 'I didn\'t keep up with my tasks on goalkeeper so now I have to donate to charity!', 'audience' => 'friends', 'access_token' => session[:access_token]}).body
	end
	
end
