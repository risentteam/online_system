class UsersController < ApplicationController
	before_action :signed_in_user , except: [:new, :create]
	#before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: [:index, :workers, :destroy ]

	def index
		@name = "Клиенты"
		@users = User.client.paginate(page: params[:page])
	end

	def workers
		@name = "Рабочие"
		@users = User.worker
		render "index"
	end

	def req
		@user = User.find(params[:id])
	end

	def reqclient
		@user = User.find(params[:id])
	end

	def contract
		@user = User.find(params[:id])
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
		@user = User.new(user_new_params)
		@user.status = "client"
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

		def user_new_params
			params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
		end

	include TableHelper
	include CalendarHelper

end
