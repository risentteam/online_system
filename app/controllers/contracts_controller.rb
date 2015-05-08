class ContractsController < ApplicationController
	def import
      flash[:info] = "Начал обработку файла"
	  Contract.import(params[:file].path)
	  redirect_to "/contracts"
	end
	
	def index
		@contracts = Contract.includes(:buildings)
	end

	def show
		@contract = Contract.find(params[:id])
	end

	def  edit
		@contract = Contract.find(params[:id])
		@list_buildings = Building.all
	end

	def new
		@contract = Contract.new
	end

	def create 
		@contract = Contract.new(contracts_params)
		if @contract.save 
			flash[:success] = "Контракт создан"
			redirect_to @contract
		else
			render 'new'
		end
	end


	def update
		#Необходимо добавить проверку корректности данных
		@contract = Contract.find(params[:id])
		@buildings=@contract.buildings

		all_buildings_id = Array(params[:buildings])
		buildingscontracts = @contract.buildingscontracts
		buildingscontracts.where(contract_id: @contract.id).destroy_all
		
		all_buildings_id.each do |building_id|
			buildingscontracts.find_or_create_by(building_id: building_id)
		end


		if @contract.update_attributes(contracts_params)
			flash[:success] = "Контракт успешно изменен"
			redirect_to @contract
		else
			render 'edit'
		end
	end

	def ajax_index
		
	end

	private
		def contracts_params
			params.require(:contract).permit(:company, :comment,
				:description, :name_contract, :end_time, :begin_time)
		end
end
