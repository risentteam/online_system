class StaticPagesController < ApplicationController

	def home
	end

	def help
	end

	def ajaxPages
		@company = params[:company]
		@list_company =  Contract.where("company = ? ", @company)
		# // render :text => @list_company.first.period_contract
    	render :json => @list_company
#		render json: @list_company, methods: [:contract_id, :description]
#		render :json => {id: @list_company.first.contract_id, description: @list_company.first.description, time: @list_company.first.date_of_signing.strftime("%e %B %Y %H:%M")}
	   	end
end
