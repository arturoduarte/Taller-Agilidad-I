Rails.application.routes.draw do
	#Usuarios
	devise_for :users
	resources :users
	
	#Productos y ordenes
	resources :products do
		#ruta para ir agregando los productos al carrito
		get 'orders', as: 'ordenar', to: 'orders#create'
	end
	
	
	
	#--------CARRITO---------------
	#listar ordenes
	get 'carro', to: 'orders#index'
	#Limpiar Carro
	get 'clean_orders', to: 'orders#clean'
	#Borrar una Orden
	get 'delete/:id', to: 'orders#destroy', as: 'delete'
	#Pago de productos ordenados
	get 'pay', to: 'orders#pay'
	#Sumar cantidad de articulo
	get 'sumar/:id/:accion', to: 'orders#calcular', as: 'suma'
	#Restar cantidad de articulo
	get 'restar/:id/:accion', to: 'orders#calcular', as: 'restar'
	
	#--------CARRITO-------------------
	
	#--------DELIVERY-------------------
	get 'deliveries/:id/entregado/', to: 'deliveries#entregado', as: 'delivery'
	#--------DELIVERY-------------------
	
	
	get 'deliveries', to: 'deliveries#index'
	
	# authenticated :user do
	# 	#--------Entrega-------------------
	# 	root 'deliveries#index', as: :root
	# 	#--------Entrega-------------------
	# end
	
	#listado de productos
	root 'products#index'
	
	
	
end


