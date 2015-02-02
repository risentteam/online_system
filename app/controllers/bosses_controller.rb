class BossesController < ApplicationController
	def new
		@boss = Boss.new
	end

	def create

	end

	def choose
		@user = User.find(params[:id])
		@list = Boss.all
	end

	def set
		u = User.find(params[:id])
		u.boss_id = params[:boss_id]
		u.save
		flash[:success] = "Начальник назначен"
		redirect_to user_path(u)
	end

	def edit
		
	end

	def update

	end

	def index
		@bosses = Boss.all
	end
end
