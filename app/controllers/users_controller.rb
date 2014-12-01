class UsersController < ApplicationController
	before_action :signed_in_user , except: [:new]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: [:index, :workers, :destroy ]

	def index
		@name = "Клиенты"
		@users = User.client.paginate(page: params[:page])



		
	end

	def workers
		@name = "Рабочие"
		@users = User.worker.paginate(page: params[:page])
    	@arrivals = Arrival.where("begin_or_end is not null")
		render "index"
	end

	def show
		if !signed_in?
			flash[:warning] = "Для просмотра своего профиля необходимо авторизироваться!"
			redirect_to signin_path
		end
		@user = User.find(params[:id])
	end
	
	def new
		@user = User.new
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to users_url
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Вы успешно зарегестрировались!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		if !signed_in?
			flash[:warning] = "Для редактирования своего профиля необходимо авторизироваться!"
			redirect_to signin_path
		end
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Профиль успешно изменен"
			redirect_to @user
		else
			render 'edit'
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :phone)
		end

	include TableHelper
	include CalendarHelper

end
