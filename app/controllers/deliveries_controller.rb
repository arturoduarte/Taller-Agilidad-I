class DeliveriesController < ApplicationController
	before_action :authenticate_user!, :filter_admin!
	
	def index
		#listo todas las ordenes pagadas(aquí aparecen también las entregadas)
		orders = Order.where(payed: true).select(:id,:payed,:date_pay,:user_id)
		
		# listo todas las ordenes pagadas y entregadas
		detalles = OrderDetail.where(order_id: orders.ids, delivered: false).select('order_id').distinct.to_a
		ordenes_pendientes = []
		detalles.each do |datos|
			ordenes_pendientes << datos.order_id 
		end
		
		#Listo SOLO las ordenes pagadas y no entregadas 
		@orders = Order.where(id: ordenes_pendientes).select(:id,:payed,:date_pay,:user_id)
	end  
	
	
	def entregado
		detalle = OrderDetail.find(params[:id])
		detalle.delivered = true
		
		entrega = Delivery.find_by(order_detail_id: detalle)
		entrega.date_delivery = Time.now
		entrega.observation = 'Entrega sin contratiempos'
		# byebug
		detalle.save
		if entrega.save
			redirect_to ordenes_root_path
		end
		
	end
	
end
