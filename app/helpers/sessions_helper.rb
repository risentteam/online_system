module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
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
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

##for redericting
	def admin_user
		unless current_user.admin?
		redirect_to root_url, warning: "Доступ к этой странице имеет только администратор."
		end
	end

	def client_user
		unless current_user.client?
		redirect_to root_url, warning: "Доступ к этой странице имеет только клиент."
		end
	end

	def worker_user
		unless current_user.worker?
		redirect_to root_url, warning: "Доступ к этой странице имеет только рабочий."
		end
	end

	def client_admin_user
		unless current_user.client? || current_user.admin?
		redirect_to root_url , warning: "Доступ к этой странице имеет только клиент или администратор."
		end
	end

	def client_worker_user
		unless current_user.client? || current_user.worker?
		redirect_to root_url, warning: "Доступ к этой странице имеет только клиент или рабочий."
		end
	end

	def worker_admin_user
		unless current_user.worker? || current_user.admin?
		redirect_to root_url, warning: "Доступ к этой странице имеет только рабочий или администратор."
		end
	end
	# Before filters

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, warning: "Пожалуйста войдите."
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
	
end
