class ContractsController < ApplicationController
	def import
	  Contract.import(params[:file])
	  redirect_to "/"
	end
end
