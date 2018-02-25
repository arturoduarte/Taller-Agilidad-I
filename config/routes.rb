Rails.application.routes.draw do
	#Productos y ordenes
	resources :products do
		#ruta para ir agregando los productos al carrito
		get 'orders', as: 'ordenar', to: 'orders#create'
	end

	#listado de productos
	root 'products#index'

	#--------CARRITO---------------
	#listar ordenes
	get 'carro', to: 'orders#index'
	#Limpiar Carro
	get 'clean_orders', to: 'orders#clean'
	#Pago de productos ordenados
	get 'pay', to: 'orders#pay'
	#--------CARRITO-------------------

	#--------Entrega-------------------
# get
	#--------Entrega-------------------

	

	#Usuarios
	devise_for :users
	resources :users
end


