#encoding: utf-8
class RequistionsController < ApplicationController
	before_action :signed_in_user
	before_action :admin_user, only: [:index]
	before_action :client_user, only: [:new, :create]
	before_action :client_admin_user, only: [:edit, :update]
	

	# show create index edit update new
	helper_method :sort_column, :sort_direction
	
	def count
		render text: Requistion.received.count.to_s
	end

	def show
		@requistion = Requistion.find(params[:id])
	end

	def create
		@requistion = Requistion.new(requistions_params)
		if @requistion.save
			flash[:success] = "Заявка отправлена"
			current_user.pairs.create!(requistion_id: @requistion.id)
			message = MainsmsApi::Message.new(sender: '3B-online', message: 'Ваша заявка №'+@requistion.id.to_s+' принята', recipients: ['89611600018'])
			response = message.deliver
			#UserMailer.welcome_email(@requistion).deliver
			redirect_to @requistion
		else
			flash[:warning] = "Вы ошиблись при заполнении формы"
			redirect_to "/requistions/new"
		end
	end

	def index
		@requistions = Requistion.order(sort_column + " " + sort_direction)
	end

	def edit
		@requistion = Requistion.find(params[:id])
		@list_worker = User.worker
		@list_contract = @requistion.building.contracts
		@list_company = Contract.all
		@list_boss = Boss.all
	end

	def update_contracts
		@list_company =  Contract.where("company = '#{params[:company]}' "	)
		render :partial => "versions", :object => @list_company
	end

	def update_date
 		@contract = Contract.find(params[:contract])
		render json: @contract, methods: [:contract_id, :description, :name_contract, :end_time, :begin_time	]
	end


	def update
		#Необходимо добавить проверку корректности данных
		@requistion = Requistion.find(params[:id])

		if @requistion.update_attributes(
			contract_id: params[:contract], 
			category: params[:requistion][:category])
#			,status: "worker_sended")
				
=begin
			rescue Exception => e
				
			end			@pair = @requistion.pairs.create(user_id: params[:worker])
			all_workers = [params[:worker]]
			count = 1
			
			until (params[("worker" + count.to_s).to_sym].nil?) do
				str = ("worker" + count.to_s).to_sym
				all_workers << params[str]
				@requistion.pairs.create(user_id: params[str])
				count += 1
			end

			flash[:success] = "Заявка успешно изменена"
			text = 'По вашей заявке №' + @requistion.id.to_s + ' выслан(ы) '
			all_workers.each { |id| text += ' ' + User.find(id).name}
			text += "."
			flash[:info] = text
			message = MainsmsApi::Message.new(
				sender: '3B-online',
				message: text,
				recipients: ['89885333165'])
			response = message.deliver
=end

			redirect_to @requistion

		else 
			render 'edit'
		end
	end

	def new
		@requistion = Requistion.new
		@list = Building.where(	
		"id in (SELECT building_id FROM buildingscontracts 
		WHERE contract_id in 
		(SELECT id FROM contracts t WHERE user_id = ?))", current_user[:id])
	end


	private
		def requistions_params
			params.require(:requistion).permit(:object, :contact_name, :contact_phone, :type_requistion, :subtype_requistion, :building_id, :requistion_comment)
		end

		def manager_params
			params.require(:requistion).permit(:contract)
		end

		def sort_column
			Requistion.column_names.include?(params[:sort]) ? params[:sort] : "status"
		end

		def sort_direction
			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
		end
		
end
