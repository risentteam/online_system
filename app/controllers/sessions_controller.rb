class SessionsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# Sign the user in and redirect to the user's show page.
			not_remeber = (params[:session][:not_remember_me] == '1')
			sign_in user, not_remeber
			if not_remeber
				flash[:info] = "Не запоминать"
			else
				# flash[:info] = "Запомнить"
			end
			redirect_back_or user
		else
		# Create an error message and re-render the signin form.
		flash.now[:danger] = 'Неправильная комбинация пароля и почты'
		render 'new'
		end
	end

	def destroy
	    sign_out
	    redirect_to root_url
 	end
end

