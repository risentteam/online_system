class ContractsController < ApplicationController
	def import
	  Contract.import(params[:file])
	  redirect_to "/contracts"
	end
	
	def index
		@contracts = Contract.all
	end

	def update
	    contract = Contract.limit(1).offset(params["rowId"]).first
	    case params["id"]
	    when "company"
			contract.update_attribute(:company, parms["value"])
		when "description"
			contract.update_attribute(:description, params['value'])
		when "comment"
			contract.update_attribute(:comment, params['value'])
		when "begin_time"
			contract.update_attribute(:begin_time, params['value'])			
		when "end_time"
			contract.update_attribute(:end_time, params['value'])			
		# when "building"
	   #      adreses = params['value'].split(';')
    	#   	adreses.each do |i|
     #        str_re = /\s*(.*)\s*/
     #        rez = str_re.match(i).string
	   #    		if Building.where("arrival_address = ? ", rez).empty?
	   #    			building = Building.create(arrival_address: rez)
	   #    		else
	   #    			building = Building.where("arrival_address = ? ", rez).first
	   #    		end
	   #    		if not Buildingscontract.where("building_id =  ? and contract_id = ?", building.id, contract.id).empty?
	   #    			Buildingscontract.create(building_id: building.id, contract_id: contract.id)
	   #    		end
     #  		end
		end			
      render :text => params['value']
	end
end
