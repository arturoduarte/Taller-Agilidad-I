class OrdersController < ApplicationController
	before_action :authenticate_user!
	
	def index
		super#hereda del aplication-controller
		
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
			if current_user.admin? 
				#para que no redireccione al root del admin
				redirect_to products_path
			else
				# para los user no admin
				redirect_to root_path
			end
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
	
	
	def destroy
		elemento = OrderDetail.find(params[:id])
		##extraigo el codigo de la cabecera
		codigo_cabcera = elemento.order_id
		# elimino el elemento
		elemento.destroy
		
		# verifico si el elemento eliminado era el último,
		# de acuerdo a esto para también eliminar la cabecera
		if Order.find(codigo_cabcera).order_details.count == 0
			Order.find(codigo_cabcera).destroy
			redirect_to carro_path
		elsif
			redirect_to carro_path
		end
	end
	
	
	def calcular
		# traemos todos los elementos
		elemento = OrderDetail.find(params[:id])
		# si la acción es sumar
		if params[:accion] == 'sumar'
			elemento.quantity += 1
			elemento.save
			# si la acción es restar
		elsif params[:accion] == 'restar'
			elemento.quantity -= 1
			elemento.save
		end
		redirect_to carro_path
	end
end