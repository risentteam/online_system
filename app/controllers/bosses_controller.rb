class BossesController < ApplicationController
	def new
		@boss = Boss.new
	end

	def show
		@boss = Boss.find(params[:id])
	end

	def create
		@boss = Boss.new(boss_params)
		if @boss.save
			flash[:success] = "Начальник успешно создан"
			redirect_to @boss
		else
			render 'new'
		end
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
		@boss = Boss.find(params[:id])
	end

	def update
		@boss = Boss.find(params[:id])
		if @boss.update_attributes(boss_params)
			flash[:success] = "Данные начальника успешно изменены"
			redirect_to @boss
		else
			render 'edit'
		end
	end

	def index
		@bosses = Boss.all
	end

	private
		def boss_params
			params.require(:boss).permit(:name, :phone, :region, :specialization,
				:begin_of_rest, :end_of_rest)
		end
end
