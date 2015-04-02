class UsersController < ApplicationController
	before_action :signed_in_user , except: [:new, :create, :reset_password]
	#before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: [:index, :workers, :destroy, :admin_create, :admin_new ]
	before_action :worker_user,    only: [:req]

	def index
		@name = "Клиенты"
		@users = User.client.paginate(page: params[:page])
	end

	def workers
		@users = User.worker
	end

	def admins
		@users = User.admin
	end

	def req
		@user = User.find(params[:id])
		@all_pairs = @user.pairs
	end

	def reqclient
		@user = User.find(params[:id])
		@requistions = @user.requistions.order(id: :desc)
	end

	def contract
		@user = User.find(params[:id])
	end

	def show
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
		#not unique id
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

	def change_password
		@user = User.find(params[:id])
		if @user.update_attributes(pass_params)
			flash[:success] = "Пароль успешно изменен"
		else
			flash[:warning] = "Введеные пароли не совпадают"
		end
		redirect_to @user
	end

	def admin_new
		@user = User.new
	end

	def admin_create
		@user = User.new(user_new_params_admin)
		@user.status = "admin"
		if @user.save
			flash[:success] = "Вы успешно создали пользователя!"
			redirect_to user_path(@user)
		else
			render 'admin_new'
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :phone, :region, :specialization)
		end

		def pass_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		def user_new_params
			params.require(:user).permit(:name, :email, :phone,
				:password, :password_confirmation, :region, :specialization)
		end

		def user_new_params_admin
			params.require(:user).permit(:name, :email, :phone,
				:password, :password_confirmation, :status, :region, :specialization)
		end

	include TableHelper
	include CalendarHelper

end
