module UsersHelper



	def countOfEntries (user)

		user.arrivals.where(begin_or_end: 0).where(:date => Date.today.beginning_of_month..Date.today.end_of_month).count
	    
		
	end
end







