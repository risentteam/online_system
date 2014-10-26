#encoding: utf-8
class BuildingsController < ApplicationController
	before_action :signed_in_user
	before_action :admin_user, only: [:index]
	before_action :client_admin_user, only: [:create, :new,]
	before_action :worker_user, only: [:check_in, :check_out]

	def for_worker
		@building = Building.find (params[:id])
		@list_requistion = Requistion.where(object: @building.name).take	#получаем заявку с данным объектом
		
		if @list_requistion.nil?
			flash[:error] = "No such request"
			#redirect_to action: 'no_build' and return
			#render 'no_build'
			render 'show'
		else
			@id_users = Pair.find_by(requistion_id: @list_requistion.id).attributes['user_id']	#находим айди рабочих на данном объекте через айди заявки
			@list_users = User.find (params[:@id_users])	#получаем список рабочих
			if (@list_users.name != current_user.name)
				flash[:error] = "No such worker"
				redirect_to action: 'no_build' and return 
			end
		end
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
		@buildings = Building.all;
	end
	

	def check_in
		@list_pair_requistion_user = Pair.where("user_id = ? and requistion_id in (SELECT id FROM requistions WHERE building_id = ?)", current_user[:id], params[:id])
		for requistion in @list_pair_requistion_user
			requistion.update_attributes(:check_in => Time.zone.now.to_s)
		end
		@list_requistion = Requistion.where("building_id = ? and id in (SELECT requistion_id FROM pairs WHERE user_id = ?)", params[:id], current_user[:id])
		for requistion in @list_requistion
			requistion.update_attributes(:status => "Рабочие прибыли")
		end
				flash[:success] = "Ваше прибытие отмечено!"
				redirect_to current_user
	end

	def check_out
		@list_requistion = Pair.where("user_id = ? and requistion_id in (SELECT id FROM requistions WHERE building_id = ?)", current_user[:id], params[:id])
		for requistion in @list_requistion
			requistion.update_attributes(:check_out => Time.zone.now.to_s)
		end
		@list_requistion = Requistion.where("building_id = ? and id in (SELECT requistion_id FROM pairs WHERE user_id = ?)", params[:id], current_user[:id])
		for requistion in @list_requistion
			requistion.update_attributes(:status => "Рабочие отбыли")
		end
			flash[:success] = "Ваше отбытие отмечено!"
			redirect_to current_user
	end


	private
		def building_params
			params.require(:building).permit(:name, :main_address)
		end

end