class RequistionsController < ApplicationController
	before_action :signed_in_user, except: [:mark]
	before_action :admin_user, only: [:index]
	before_action :client_user, only: [:new, :create, :mark]
	before_action :client_admin_user, only: [:edit, :update]
		
	def count
		render text: Requistion.fresh.count.to_s
	end

	def count_all
		render :json => { :count => Requistion.fresh.count.to_s} 
	end

	def show
		@requistion = Requistion.find(params[:id]) 
	end

	def to_take_in_work
		@requistion = Requistion.find(params[:id]) 
		if @requistion.update_attributes(
			status: "adopted_in_work", time_adopted_in_work: Time.zone.now.to_s)
			flash[:success] = "Заявка принята в разработку"
			redirect_to @requistion
		end
	end

	def close
		@requistion = Requistion.find(params[:id]) 
		if @requistion.update_attributes(
			status: "comleted", time_comleted: Time.zone.now.to_s)
			flash[:success] = "Заявка сдана в архив"
			redirect_to @requistion
		end
	end

	def done
		@requistion = Requistion.find(params[:id]) 
		if @requistion.update_attributes(
			status: "done", time_done: Time.zone.now.to_s)
			flash[:success] = "Заявка закончена"
			redirect_to @requistion
		end		
	end

	def cancel
		@requistion = Requistion.find(params[:id])
		render "cancel"

	end

	def canceldone
		@requistion = Requistion.find(params[:id])

		@requistion.requistion_comment = @requistion.requistion_comment + "/n" + params[:subject]
		@requistion.status = "canceled"

	end
	

	def mark
		@requistion = Requistion.find(params[:id]) 
		@requistion.update_attribute( :raiting, params[:mark])
		flash[:success] = "Оценка поставлена"
		redirect_to requistion_path(@requistion)
	end

	def change_status
		@requistion = Requistion.find(params[:id]) 
		@requistion.update_attribute( :status, params[:status])
		case params[:status]
			when "fresh"
				@requistion.update_attributes(
					created_at: Time.zone.now.to_s)
			when "assigned"
				@requistion.update_attributes(
					time_assgned: Time.zone.now.to_s)
			when "adopted_in_work"
				@requistion.update_attributes(
					time_adopted_in_work: Time.zone.now.to_s)
			when "running"
				@requistion.update_attributes(
					time_running: Time.zone.now.to_s)
			when "done"
				@requistion.update_attributes(
					time_done: Time.zone.now.to_s)
			when "comleted"
				@requistion.update_attributes(
					time_comleted: Time.zone.now.to_s)
			end
		flash[:success] = "Статус изменен"
		redirect_to requistion_path(@requistion)		
	end



	def create
		@requistion = Requistion.new(requistions_params)
		if @requistion.save
			flash[:success] = "Заявка отправлена"
			current_user.pairs.create!(requistion_id: @requistion.id)
			if (current_user.phone != "")
				message = MainsmsApi::Message.new(sender: '3B-online',
					message: 'Ваша заявка №'+@requistion.id.to_s+' принята',
					recipients: [current_user.phone])
				response = message.deliver
			end
			#UserMailer.welcome_email(@requistion).deliver
			redirect_to @requistion
		else
			flash[:warning] = "Вы ошиблись при заполнении формы"
			redirect_to "/requistions/new"
		end
	end

	def index
		@name = "Все заявки"
		@requistions = Requistion.all
#		@requistions = Requistion.this_month

	end

	def all_new
		@name = "Новые заявки"
		@requistions = Requistion.fresh	
		render "index"
	end

	def edit
		@requistion = Requistion.find(params[:id])
#		if @requistion.status=="comleted"
#			redirect_to @requistion
#		end
		@list_worker = User.worker
		@list_contract = @requistion.building.contracts.select("company").distinct
		@list_company = Contract.all
		@list_boss = Boss.all
	end

	def update_contracts
		@list_company =  Contract.where("company = '#{params[:company]}'")
		render :partial => "versions", :object => @list_company
	end

	def update_date
 		@contract = Contract.find(params[:contract])
#		render json: @contract, methods: [:contract_id, :description, :name_contract, :end_time, :begin_time]
		render :json => { :contract_id => @contract.contract_id, 
						  :description => @contract.description, 
						  :name_contract => @contract.name_contract, 
						  :time =>  "С "+Russian::strftime(@contract.begin_time, "%e %B %Y")+" до "+Russian::strftime(@contract.end_time, "%e %B %Y")}
	end


	def update
		#Необходимо добавить проверку корректности данных
		@requistion = Requistion.find(params[:id])					
		if @requistion.update_attributes(
			contract_id: params[:version_id],
			time_deadline: params[:deadline], 
			category: params[:requistion][:category],
			requistion_comment: params[:requistion][:requistion_comment],
			status: 'assigned',
			time_assgned: Time.zone.now.to_s)
			client = @requistion.users.client.first
			@pair = @requistion.pairs.create(user_id: params[:worker])
			all_workers = [params[:worker]]
#			send_to_boss params[:worker]
			count = 1
			
			until (params[("worker" + count.to_s).to_sym].nil?) do
				str = ("worker" + count.to_s).to_sym
				all_workers << params[str]
#				send_to_boss params[str]
				@requistion.pairs.create(user_id: params[str])
				count += 1
			end

			flash[:success] = "Заявка успешно изменена"
			text = 'По вашей заявке №' + @requistion.id.to_s + ' выслан(ы) '
			all_workers.each { |id| text += ' ' + User.find(id).name}
			text += "."
			flash[:info] = text
			if (not client.phone.nil?)
				message = MainsmsApi::Message.new(
					sender: '3B-online',
					message: text,
					recipients: [client.phone])
				response = message.deliver
			end




			
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

		def send_to_boss(worker_id)
			user = User.find(worker_id)
			boss = user.boss
			if (boss.phone != "")
				message = MainsmsApi::Message.new(
					sender: '3B-online',
					message: "Проконтролируйте #{user.name}",
					recipients: [boss.phone])
				response = message.deliver
			end
		end
end
