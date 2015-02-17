class StaticPagesController < ApplicationController
	def panel	
	end

	def staff
		@bosses = Boss.all
		@workers = User.worker.all
	end

	def home
		if signed_in? && current_user.admin?
			render "panel"
		else
			render "sessions/new"
		end
	end
end
