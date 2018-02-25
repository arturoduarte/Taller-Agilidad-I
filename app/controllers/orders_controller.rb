class OrdersController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@orders = OrderDetail.where(
		order_id: Order.where(
		user_id: User.find(2), payed: false).ids)
		
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
			redirect_to root_path
		end
	end
	
	def pay
		#busco las ordenes del user actual, NO pagado
		orderCabecera = current_user.orders.where(payed: false)
		# busco el detalle de acuerdo al orden cabecera
		orderDetalle = OrderDetail.where(order_id: orderCabecera)
		#fecha y hora actual
		fechaPago = Time.now
		
		#Almaceno la orden a entregar
		orderDetalle.each do |i|
			Delivery.create(order_detail_id: i.id)
		end
		# guardo cabecera Order
		if orderCabecera.update(payed: true, date_pay: fechaPago)
			redirect_to root_path, notice: 'Su pedido será entregado en breve'
		end
	end
	
	def clean
		@orders = current_user.orders.where(payed: false)
		@orders.destroy_all
		redirect_to carro_path, notice: 'El carro se ha vaciado.'
	end
end
