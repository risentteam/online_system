App::Application.routes.draw do

  get 'password_resets/new'

	root 'static_pages#home'
	post "static_pages/ajaxPages"
	match '/ajax', to: 'static_pages#ajaxPages', via: 'post'

	resources :users
	match '/workers',  to: 'users#workers',       via: 'get'
	match 'users/:id/req', to: 'users#req', via: 'get'
	match 'users/:id/contract', to: 'users#contract', via: 'get'
	match 'users/:id/reqclient', to: 'users#reqclient', via: 'get'
 	match 'user/:id/change_password', to: 'users#change_password', via: 'post', as: "change_password"
 	match '/admin_new',  to: 'users#admin_new',       via: 'get'
 	match '/admin_create',  to: 'users#admin_create',       via: 'post'
 	match "/users/:id/choose_manager", to: 'bosses#choose', via: 'get'
 	match "/users/:id/set_manager", to: 'bosses#set', via: 'patch'

	resources :sessions, only: [:new, :create, :destroy]
	resources :arrivals
	match '/arrivals', to: 'arrivals#index', via: 'get', as: 'index'
 #	match '/arrivalfromto', to: 'arrivals#arrivalfromto', via: 'post', as: "arrivalfromto"	

	resources :bosses

	match '/panel',  to: 'static_pages#panel',    via: 'get'
	match '/signup',  to: 'users#new',            via: 'get'
	match '/signin',  to: 'sessions#new',         via: 'get'
	match '/signout', to: 'sessions#destroy',     via: 'delete'
	resources :password_resets
	
	match '/help',    to: 'static_pages#help',    via: 'get'

	resources :requistions
	match '/count', to: 'requistions#count', via: 'get'
	match '/count_all', to: 'requistions#count_all', via: 'get'
	match '/new', to: 'requistions#new', via: 'get'
	match 'requistions/:id/mark', to: 'requistions#mark', via: 'post', as:"mark"
 	match 'requistions/:id/change_status', to: 'requistions#change_status', via: 'post', as: "change_status"
	match '/requistions', to: 'requistions#index', via: 'get'
	match '/new_requistions',  to: 'requistions#all_new',            via: 'get'
	match "/update_contracts", to: "requistions#update_contracts", via: 'get'	
	match "/update_date", to: "requistions#update_date", via: 'get'	
  	match 'requistions/:id/close', to: 'requistions#close', via: 'get'
  	match 'requistions/:id/raiting', to: 'requistions#raiting', via: 'get'
  	match 'requistions/:id/to_take_in_work', to: 'requistions#to_take_in_work', via: 'get'
  	match 'requistions/:id/done', to: 'requistions#done', via: 'get'
  	match 'requistions/:id/cancel', to: 'requistions#cancel', via: 'get'
  	match 'requistions/:id/canceldone', to: 'requistions#canceldone', via: 'post', as: "canceldone"
  	match '/view_change_time', to: 'requistions#view_change_time', via: 'get'

	resources :requistions do
  		get :autocomplete_building_arrival_address, :on => :collection
	end

  	resources :contracts do
  		collection { post :import }
	end
	match "/contracts", to: 'contracts#index', via: 'get' 
	match "/UpdateData", to: 'contracts#update', via: 'post'

  	resources :buildings
  	match 'buildings/:id/check_in', to: 'buildings#check_in', via: 'get'
  	match 'buildings/:id/check_out', to: 'buildings#check_out', via: 'get'
  	match 'no_build', to: 'buildings#no_build', via: 'get'
  	match 'buildings/:id', to: 'buildings#update', via: 'put'


  	#match 'tests/:id', to: 'users#test', via: 'get', constraints: {id: /\d+/}

	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
end
