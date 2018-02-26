class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	
	def index
		#@quantity_order para el navbar
		@quantity_order = OrderDetail.where(
		order_id: Order.find_by(
		user: current_user,payed: false)).sum('quantity')
	end
	
	private
	# para permitir el acceso solo al administrador
	def filter_admin!
		authenticate_user!
		redirect_to root_path, alert: "No tienes acceso" unless current_user.admin?
	end
	
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
	end
	
	
	
end
