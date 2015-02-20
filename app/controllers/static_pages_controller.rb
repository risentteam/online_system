class StaticPagesController < ApplicationController
	before_action :signed_in_user

	def panel	
	end

	def staff
		@bosses = Boss.all
		@workers = User.worker.all
	end

	def home
		if current_user.admin?
			@name = "Новые заявки"
			@requistions = Requistion.fresh	
			render "requistions/index"
		else
			@user = current_user
			render "users/show"
		end
	end
end
