class ArrivalsController < ApplicationController
	def index
=begin
		if (params[:date].nil? or params[:date][:from].empty?)
			@date_from = Time.now.beginning_of_month.strftime("%Y-%m-%d")
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
=end
@time_from = '00:00'
@time_to = '23:59'
if (params[:date].nil? or params[:date].empty?)
	@date_from = Time.now.strftime("%Y-%m-%d")
	@date_to = Time.now.strftime("%Y-%m-%d")
else
	@date_from = @date_to = params[:date]
end

		@result = Arrival.includes(:building, :user).where('date between ? and ?', @date_from, (DateTime.parse(@date_to)+1.day).strftime("%Y-%m-%d") ).\
			where("to_char(date, 'HH24') between ? and ? or to_char(date, 'HH24')= ? and to_char(date, 'MI') >= ? or to_char(date, 'HH24')= ? and to_char(date, 'MI') <= ?",
			(@time_from[0,2].to_i+1).to_s, (@time_to[0,2].to_i-1).to_s, @time_from[0,2], @time_from[3, 2], @time_to[0, 2], @time_to[3, 2])
	end
end
