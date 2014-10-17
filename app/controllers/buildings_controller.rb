class BuildingsController < ApplicationController
	before_action :require_login, :only=>[:show]

	def for_worker
		@building = Building.find (params[:id])
		@list_requistion = Requistion.where(object: @building.name).take	#получаем заявку с данным объектом
		
		if @list_requistion.nil?
			flash[:error] = "No such request"
			redirect_to action: 'no_build' and return
			render 'no_build'
		else
			@id_users = Pair.find_by(requistion_id: @list_requistion.id).attributes['user_id']	#находим айди рабочих на данном объекте через айди заявки
			@list_users = User.find (params[:@id_users])	#получаем список рабочих
			if (@list_users.name != current_user.name)
				flash[:error] = "No such worker"
				redirect_to action: 'no_build' and return 
			end
		end

	end

	def no_build

	end

	def create 
		@building = Building.new (building_params)
		if @building.save 
			redirect_to @building
		else
			render 'new'
		end
	end

  	def new
  		@building = Building.new
	end

	def show 
    	@building = Building.find(params[:id])
		@list_requistion = Requistion.where("id in (SELECT requistion_id FROM pairs WHERE user_id = ?) and building_id = ?", current_user[:id], params[:id])
	end

	def index
		@buildings = Building.find(:all);
	end
	

	def check_in
	    @building = Building.find(params[:id])
		@list_requistion = Pair.where("user_id = ? and requistion_id in (SELECT id FROM Requistion WHERE building_id = ?)", current_user[:id], params[:id])
	end

	def check_out
	end


	private
	def building_params
		params.require(:building).permit(:name, :main_address)
	end
 
	def require_login
		unless !current_user.nil?
			flash[:error] = "You must be logged in to access this section"
			redirect_to "/sessions/new"
		end
	end

end