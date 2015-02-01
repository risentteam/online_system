class StaticPagesController < ApplicationController
	def panel	
	end

	def home
		if signed_in? && current_user.admin?
			render "panel"
		else
			render "sessions/new"
		end
	end
end
