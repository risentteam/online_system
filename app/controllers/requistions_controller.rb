#encoding: utf-8
class RequistionsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def show
    @requistion = Requistion.find(params[:id])
  end

  def create
  	@requistion = Requistion.new(requistions_params)
  	if @requistion.save
      @requistion.update_attributes(:status => 'Заявка принята')
      flash[:success] = "Profile created"
      #UserMailer.welcome_email(@requistion).deliver
      redirect_to @requistion
    else
      render 'new'
    end
  end

  def index
    @requistions = Requistion.order(sort_column + " " + sort_direction)
  end

  def edit
    @requistion = Requistion.find(params[:id])
    @list_worker = User.all
    @list_contract = Contract.all
    @list_boss = Boss.all
    @list_building = Building.all
  end

  def update
    @requistion = Requistion.find(params[:id])
    if !params[:contract].blank? and !params[:requistion][:category].blank? and @requistion.update_attributes(:contract => params[:contract], :category => params[:requistion][:category], :status => "Бригада отправлена")
          @pair = @requistion.pairs.create(:user_id => params[:worker])
          if @pair.save
            flash[:success] = "Profile updated"
            redirect_to @requistion
          else
            @requistion.update_attributes(:contract => '', :category => '', :status => "Заявка принята")
            render 'new'
          end
    else 
#вот здесь падает
      render 'new'
    end
  end

  def new
  	@requistion = Requistion.new
    @list = Building.where("id in (SELECT building_id FROM buildingscontracts WHERE contract_id in (SELECT contract_id FROM contracts t WHERE user_id = ?))", current_user[:id])
  end


  private
  def requistions_params
  		params.require(:requistion).permit(:object, :main_address, :arrival_address, :contact_name, :contact_phone, :type_requistion, :building_id)
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
