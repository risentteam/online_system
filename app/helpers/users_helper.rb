module UsersHelper

def countOfMissings (user)
	t = 30
	 concat("<div>")
	user.arrivals.where('begin_or_end >= 0 AND date').each do |arrival|
		
			t--	if Date.today.beginning_of_month..Date.today.end_of_month.cover?(arrival.date)
	end
	if t < 0
		user
	else
		user
	end
end


end
end
