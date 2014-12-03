class BuildingsController < ApplicationController
	before_action :signed_in_user
	before_action :admin_user, only: [:index]
	before_action :client_admin_user, only: [:create, :new,]
	before_action :worker_user, only: [:check_in, :check_out]

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
		pairs = Pair.where("user_id = ? and requistion_id in (SELECT id FROM requistions WHERE building_id = ?)", current_user[:id], params[:id])
		last = current_user.arrivals.where(check_type: 0).order(:date).last(); 
		date = Time.zone.now.strftime("%Y-%m-%d")
		arrival = Arrival.create(user_id: current_user[:id], check_type: "check_in", building_id: params[:id], date: Time.zone.now.to_s)
    	#Time.zone.now.strftime("%H").to_i<=10 and Time.zone.now.strftime("%H").to_i>=8 and
    	if current_user.arrivals.where("date between date('now') AND date('now')").count==0
			arrival.update_attributes(begin_or_end: 0)
		end
		pairs.each do |pair|
			pair.requistion.update_attributes(status: "running")
		end
		flash[:success] = "Ваше прибытие отмечено!"
		redirect_to current_user
	end

	def check_out
		pairs = Pair.where("user_id = ? and requistion_id in (SELECT id FROM requistions WHERE building_id = ?)", current_user[:id], params[:id])
		arrival = Arrival.create(user_id: current_user[:id], check_type: "check_out", building_id: params[:id], time: Time.zone.now.to_s)
    	if Time.zone.now.strftime("%H").to_i<=7 and Time.zone.now.strftime("%H").to_i>=5	
			arrival.update_attributes(begin_or_end: 1)
		end
#		pairs.each do |pair|
#			pair.requistion.update_attributes(status: "worker_gone")
#		end
		flash[:success] = "Ваше отбытие отмечено!"
		redirect_to current_user
	end

	private
		def building_params
			params.require(:building).permit(:name, :main_address)
		end

end