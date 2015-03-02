class BuildingsController < ApplicationController
	before_action :signed_in_user
	before_action :admin_user, only: [:index]
	before_action :client_admin_user, only: [:create, :new,]
	before_action :worker_user, only: [:check_in, :check_out]

	respond_to :html, :json

	def search
		name = "%#{params[:name]}%"
		@buildings = Building.all.where("arrival_address ILIKE ? AND name LIKE ?", "%#{params[:q]}%", name)

		@bjson = @buildings.to_json(:only => [ :id, :name, :arrival_address ])
		render json: @bjson
	end

	def get_name
		render text: Building.find(params[:id]).name.to_s
	end

	def create
		@building = Building.new (building_params)
		if @building.save
			flash[:success] = "Здание создано"
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
		if current_user.worker?
			@list_requistion = Requistion.where(
			"id in (SELECT requistion_id FROM pairs WHERE user_id = ?) and building_id = ?",
			current_user[:id], params[:id])
		else
			@list_requistion = @building.requistions
		end

	end

	def index
		@buildings = Building.includes(:contracts);
	end

	def check
		@building = Building.find(params[:id])
	end

	def check_in
		requistion_for_buidings = current_user.requistions.where('status = 2')
		# pairs = Pair.where(
		# 	"user_id = ? and requistion_id in (SELECT id FROM requistions WHERE building_id = ?)",
		# 	 current_user[:id], params[:id])
		# last = current_user.arrivals.where(check_type: 0).order(:date).last();
		# date = Time.zone.now.strftime("%Y-%m-%d")
		arrival = Arrival.create(
			user_id: current_user[:id],
			check_type: "check_in",
			building_id: params[:id],
			date: Time.now.to_s)

  #   	if current_user.arrivals.where("date between date('now') AND date('now')").count==0
		# 	arrival.update_attributes(begin_or_end: 0)
		# end
		requistion_for_buidings.each do |f|
			f.update_attributes(status: "running", time_running: Time.now.to_s, who_running: current_user.id)
		end
		flash[:success] = "Ваше прибытие отмечено!"
		redirect_to current_user
	end

	def check_out
		pairs = Pair.where(
			"user_id = ? and requistion_id in (SELECT id FROM requistions WHERE building_id = ?)",
			current_user[:id], params[:id])
		arrival = Arrival.create(
			user_id: current_user[:id],
			check_type: "check_out",
			building_id: params[:id],
			date: Time.now.to_s)
    	if Time.zone.now.strftime("%H").to_i<=7 and Time.zone.now.strftime("%H").to_i>=5
			arrival.update_attributes(begin_or_end: 1)
		end
#		pairs.each do |pair|
#			pair.requistion.update_attributes(status: "worker_gone")
#		end
		flash[:success] = "Ваше отбытие отмечено!"
		redirect_to current_user
	end

	def update
	  @building = Building.find(params[:id])
	  @a = params[:building][:arrival_address]
		if @building.update_attributes(arrival_address: @a)
			respond_with @building
	  else
			flash[:success] = "Что-то пошло не так"
			redirect_to current_user
	  end
	end

	private
		def building_params
			params.require(:building).permit(:name ,:arrival_address, :contact_phone, :contact_name)
		end

end
