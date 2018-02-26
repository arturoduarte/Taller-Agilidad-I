class DeliveriesController < ApplicationController
	before_action :authenticate_user!
	
	def index
		if current_user.admin?
			@orders = Order.where(payed: true).select(:id,:payed,:date_pay,:user_id)
			
		else
			redirect_to products_path
		end	
	end  
end
