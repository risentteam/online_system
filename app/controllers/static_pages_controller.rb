class StaticPagesController < ApplicationController

	def home
	end

	def help
	end

	def ajaxPages
		@company = params[:company]
		@list_company =  Contract.where("company = ? ", @company)
		# // render :text => @list_company.first.period_contract
		render :json => {id: @list_company.first.contract_id, time: @list_company.first.period_contract.strftime("%e %B %Y %H:%M")}
	end
end
