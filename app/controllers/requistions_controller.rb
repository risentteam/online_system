class RequistionsController < ApplicationController
  def show
    @requistion = Requistion.find(params[:id])
  end

  def create
  	@requistion = Requistion.new(user_params)
  	if @requistion.save
      flash[:success] = "Profile created"
      #UserMailer.welcome_email(@requistion).deliver
      redirect_to @requistion
    else
      render 'new'
    end
  end

  def index
    @requistions = Requistion.all
  end

  def edit
    @requistion = Requistion.find(params[:id])
    @list_worker = Worker.all
    @list_contract = Contract.all

  end

  def update
    @requistion = Requistion.find(params[:id])
    if @requistion.update_attributes(manager_params)
      flash[:success] = "Profile updated"
      redirect_to @requistion
    else
      render 'edit'
    end
  end

  def new
  	@requistion = Requistion.new
  end


  private
  def user_params
  		params.require(:requistion).permit(:object, :main_address, :arrival_address, :contact_name, :contact_phone, :type_requistion)
  end
  def manager_params
    params.require(:requistion).permit(:contract)
  end
end
