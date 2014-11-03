#encoding: utf-8
class RequistionsController < ApplicationController
	before_action :signed_in_user
	before_action :admin_user, only: [:index]
	before_action :client_user, only: [:new, :create]
	before_action :client_admin_user, only: [:edit, :update]
	

	# show create index edit update new
	helper_method :sort_column, :sort_direction
	
	def count
		render text: Requistion.all.count.to_s
	end

	def show
		@requistion = Requistion.find(params[:id])
	end

	def create
		@requistion = Requistion.new(requistions_params)
		if @requistion.save
			@requistion.update_attributes(:status => 'Заявка принята')
			flash[:success] = "Заявка отправлена "
			current_user.pairs.create!(requistion_id: @requistion.id)
			message = MainsmsApi::Message.new(sender: '3B-online', message: 'Ваша заявка №'+@requistion.id.to_s+' принята', recipients: ['89611600018'])
			response = message.deliver
#			flash[:warning] = response['status']
#			flash[:warning] = response['error']
#			flash[:warning] = response['message']
			#UserMailer.welcome_email(@requistion).deliver
			redirect_to @requistion
		else
			flash[:warning] = "Вы ошиблись при заполнении формы"
				redirect_to "/requistions/new"
#			render "new" //почему не работает render?
		end
	end

	def index
		@requistions = Requistion.order(sort_column + " " + sort_direction)
	end

	def edit
		@requistion = Requistion.find(params[:id])
		@list_worker = User.where("status = 0")
		@list_contract = @requistion.building.contracts
		@list_company = Contract.all
		@list_boss = Boss.all
		@list_building = Building.all
	end

	def update_contracts
		@list_company =  Contract.where("company = ? ", params[:company])
		render :partial => "versions", :object => @list_company
	end

	def update_date
 		@contract = Contract.find(params[:contract])
		render json: @contract, methods: [:contract_id, :description, :date_of_signing]
	end


	def update
		@requistion = Requistion.find(params[:id])

		if @requistion.update_attributes(
			contract_id: params[:contract], 
			category: params[:requistion][:category], 
			status: "Бригада отправлена")

			@pair = @requistion.pairs.new(user_id: params[:worker])
			all_workers = [params[:worker]]
			count = 1
			
			until (params[("worker" + count.to_s).to_sym].nil?) do
				#str = ("worker" + count.to_s).to_sym
				#all_workers << params[str]
				#@requistion.pairs.create(user_id: params[str])
				count += 1
			end

			if @pair.save
				flash[:success] += "Заявка успешно изменена"
				text = 'По вашей заявке №'+ @requistion.id.to_s+' выслан(ы) '
				#all_workers.each { |id| text += ' ' + User.find(id).name}
				text += "."
				flass[:info] = text
				message = MainsmsApi::Message.new(
					sender: '3B-online',
					message: text,
					recipients: ['89611600018'])
				response = message.deliver
				redirect_to @requistion
			else
				@requistion.update_attributes(
					contract: '',
					category: '', 
					status: "Заявка принята")
				render 'new'
			end

		else 
#вот здесь падает
			render 'new'
		end
	end

	def new
		@requistion = Requistion.new
		@list = Building.where(
		"id in (SELECT building_id FROM buildingscontracts 
		WHERE contract_id in 
		(SELECT contract_id FROM contracts t WHERE user_id = ?))", current_user[:id])
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
