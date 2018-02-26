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
	#Pago de productos ordenados
	get 'pay', to: 'orders#pay'
	#--------CARRITO-------------------
	
	
	
	
	
	authenticated :user do
		#--------Entrega-------------------
		root 'deliveries#index', as: :authenticated_root
		#--------Entrega-------------------
	end
	
	#listado de productos
	root 'products#index'
	
	
	
end


