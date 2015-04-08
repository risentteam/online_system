module SessionsHelper
	def sign_in(user, not_remeber=true)
		remember_token = User.new_remember_token
		if (not_remeber)
			cookies[:remember_token] = remember_token
		else
			cookies.permanent[:remember_token] = remember_token
		end
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		#возможна оптимизация производительности
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in?
		!current_user.nil?
	end
	
	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def redirect_back_or(default)
		a = session[:return_to]
		b = session[:return_to] || default
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

##for redericting
	def admin_user
		unless current_user.admin?
		flash[:warning] = "Доступ к этой странице имеет только администратор."
		redirect_to root_url 
		end
	end

	def client_user
		unless current_user.client?
		flash[:warning] = "Доступ к этой странице имеет только клиент." 
		redirect_to root_url
		end
	end

	def worker_user
		unless current_user.worker?
		flash[:warning] = "Доступ к этой странице имеет только исполнитель."
		redirect_to root_url
		end
	end

	def client_admin_user
		unless current_user.client? || current_user.admin?
		flash[:warning] = "Доступ к этой странице имеет только клиент или администратор."
		redirect_to root_url
		end
	end

	def client_worker_user
		unless current_user.client? || current_user.worker?
		flash[:warning] = "Доступ к этой странице имеет только клиент или исполнитель."
		redirect_to root_url
		end
	end

	def worker_admin_user
		unless current_user.worker? || current_user.admin?
		flash[:warning] = "Доступ к этой странице имеет только исполнитель или администратор."
		redirect_to root_url
		end
	end
	# Before filters

	def signed_in_user
		unless signed_in?
			store_location
			flash[:warning] = 'Пожалуйста войдите.'
			redirect_to signin_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
	
end
