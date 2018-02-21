Rails.application.routes.draw do
  resources :products
  root 'products#index2'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
