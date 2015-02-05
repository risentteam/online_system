class ArrivalsController < ApplicationController
	def index
		if (!params[:time].nil?)
			if (!params[:time][:from].nil?)
				@from = params[:time][:from]
			else
				@from = '00:00'	
			end			
			if (!params[:time][:to].nil?)
				@to = params[:time][:to]
			else
				@to = '23:59'				
			end
			@result = Arrival.includes(:buildings, :users).where("strftime('%H', date) between ? and ? or strftime('%H', date)= ? and strftime('%M', date) >= ? or strftime('%H', date)= ? and strftime('%M', date) <= ?", 
				(@from[0,2].to_i+1).to_s, (@to[0,2].to_i-1).to_s, @from[0,2], @from[3, 2], @to[0, 2], @to[3, 2])
		else
			@result = Arrival.all
		end
	end
end
