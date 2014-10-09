class StaticPagesController < ApplicationController
  layout false
  def ajaxPages
     @company = params[:company]
     @list_company =  Contract.where("company = ? ", @company)
       render :text => @list_company.first.id
  end
end
