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
	#--------CARRITO-------------------
	
	
	#listado de productos
	root 'products#index'
	
end


