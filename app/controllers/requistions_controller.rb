class RequistionsController < ApplicationController
	before_action :signed_in_user, except: [:count, :count_all]
	before_action :admin_user, only: [:index, :edit, :update]
	before_action :client_user, only: [ :mark]

	autocomplete :building, :arrival_address, :full => true
		
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
			status: "completed", time_completed: Time.zone.now.to_s)
			flash[:success] = "Заявка завершена"
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
		r = Requistion.find(params[:id])
		r.cancel(current_user.id, params[:subject])
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
			when "completed"
				@requistion.update_attributes(
					time_completed: Time.zone.now.to_s)
			end
		flash[:success] = "Статус изменен"
		redirect_to requistion_path(@requistion)		
	end

	def view_change_time
		
		def tostr(time)
			if time
				Russian::strftime(time, " %e %B %Y %H:%M")
			else
				""
			end
		end
		r = Requistion.find(params[:id])
		if r.who_cancel
			link = "<a href='#{user_path(r.who_cancel)}'>Кто отменил</a>"
		end
		render :json => {
			time:{ 
				:created   => tostr(r.created_at),
				:assigned  => tostr(r.time_assgned),
				:adopted   => tostr(r.time_adopted_in_work),
				:running   => tostr(r.time_running),
				:done      => tostr(r.time_done),
				:completed => tostr(r.time_completed),
				:deadline  => tostr(r.time_deadline),
				:canceled  => tostr(r.time_canceled)
			},
			user:{
				:canceled  => link
			}
		}
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
			#UserMailer.new_reqistion(current_user).deliver
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
		@pos = params[:position]
		@value = params[:value]
		case @pos
			when '2'
				@object = Building.find(@value).arrival_address
			when '12'
				@object = User.find(@value).name
		end
	end

	def all_new
		@name = "Новые заявки"
		@requistions = Requistion.fresh	
		render "index"
	end

	def edit
		@requistion = Requistion.find(params[:id])
#		if @requistion.status=="completed"
#			redirect_to @requistion
#		end
		@list_worker = User.worker.order(:name)
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
#			status: 'assigned',
#			time_assgned: Time.zone.now.to_s
			)
		
			client = @requistion.users.client.first
			@pair = @requistion.pairs.find_or_create_by(user_id: params[:worker])
			all_workers = [params[:worker]]
#			send_to_boss params[:worker]
			count = 1
			
			until (params[("worker" + count.to_s).to_sym].nil?) do
				str = ("worker" + count.to_s).to_sym
				all_workers << params[str]
#				send_to_boss params[str]
				@requistion.pairs.find_or_create_by(user_id: params[str])
				count += 1
			end

			# flash[:success] = "Заявка успешно изменена"
			# text = 'По вашей заявке №' + @requistion.id.to_s + ' выслан(ы) '
			# all_workers.each { |id| text += ' ' + User.find(id).name}
			# text += "."
			# flash[:info] = text
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
		if current_user.client?
			@list = Building.where(	
				"id in (SELECT building_id FROM buildingscontracts 
				WHERE contract_id in 
				(SELECT id FROM contracts t WHERE user_id = ?))", current_user[:id])
		else
			@list = Building.order("lower(arrival_address)").all

		end
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
