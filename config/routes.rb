Rails.application.routes.draw do
	#Productos y ordenes
	resources :products do
		#ruta para ir agregando los productos al carrito
		get 'orders', as: 'ordenar', to: 'orders#create'
	end

	#listado de productos
	root 'products#index'

	#listar ordenes
	get 'carro', to: 'orders#index'
	get 'clean_orders', to: 'orders#clean'
	
	#Usuarios
	devise_for :users
	resources :users
end


