class OrdersController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@orders = OrderDetail.where(
		order_id: Order.where(
		user_id: User.find(current_user.id), payed: false).ids).order(:id)
		
		@total = @orders.collect{|i| i.price * i.quantity}.sum()
		# esto hace lo mismo
		# @total = @orders.pluck("price * quantity").sum()
	end
	
	def create
		@product = Product.find(params[:product_id])
		orderCabecera = Order.find_or_create_by(user: current_user, payed: false)
		detalle = OrderDetail.find_or_create_by(order: orderCabecera, product: @product, price: @product.price)
		detalle.quantity +=1
		
		orderCabecera.save
		if detalle.save
			# para los users no admin
			redirect_to root_path, notice: 'El producto se ha comprado con éxito!!'
		end
	end
end