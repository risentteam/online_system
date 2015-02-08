class ArrivalsController < ApplicationController
	def index
			if (params[:date].nil? or params[:date][:from].empty?)
#				@date_from = Arrival.first.date().strftime("%Y-%m-%d")
				@date_from = '2015-01-01'
			else
				@date_from = params[:date][:from]
			end
			if (params[:date].nil? or params[:date][:to].empty?)
				@date_to = Time.now.strftime("%Y-%m-%d")
			else
				@date_to = params[:date][:to]
			end
			if (params[:time].nil? or params[:time][:from].empty?)
				@time_from = '00:00'
			else
				@time_from = params[:time][:from]
			end			
			if (params[:time].nil? or params[:time][:to].empty?)
				@time_to = '23:59'
			else
				@time_to = params[:time][:to]
			end
			@result = Arrival.includes(:building, :user).where('date between ? and ?', @date_from, @date_to).\
				where("to_char(date, 'HH24') between ? and ? or to_char(date, 'HH24')= ? and to_char(date, 'MI') >= ? or strftime(date, 'HH24')= ? and strftime(date, 'MI') <= ?", 
				(@time_from[0,2].to_i+1).to_s, (@time_to[0,2].to_i-1).to_s, @time_from[0,2], @time_from[3, 2], @time_to[0, 2], @time_to[3, 2])
#		@result = Arrival.

	end
end
