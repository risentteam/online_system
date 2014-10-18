#encoding: utf-8
class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: :destroy

	def index
		@users = User.paginate(page: params[:page])
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
		# Handle a successful update.
		flash[:success] = "Профиль успешно изменен"
		redirect_to @user
	else
		render 'edit'
	end
	end

	private

		def admin_user
      		redirect_to(root_url) unless current_user.admin?
    	end

		def user_params
			params.require(:user).permit(:name, :email, :password,
																	 :password_confirmation)
		end
		# Before filters

		def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
