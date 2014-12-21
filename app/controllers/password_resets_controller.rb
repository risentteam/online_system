class PasswordResetsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:password_reset][:email])
		user.send_password_reset if user
		flash[:warning] = "Вам выслано письмо с дальнейшими инструкциями по изменению пароля"
		redirect_to signin_path
	end

	def edit
		@user = User.find_by_password_reset_token!(params[:id])
	end

	def update
		@user = User.find_by_password_reset_token!(params[:id])
		if @user.password_reset_sent_at < 2.hours.ago
			flash[:warning] = "Срок действия ссылки истек"
			redirect_to new_password_reset_path
		elsif @user.update_attributes(password_params)
			flash[:success] = "Пароль успешно изменен"
			redirect_to user_path(@user)
		else
			flash[:warning] = "Произошла ошибка"
			render :edit
		end
	end

	private
		def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end