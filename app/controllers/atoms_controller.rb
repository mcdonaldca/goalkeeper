class AtomsController < ApplicationController

	def success
	end

	def proof

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
