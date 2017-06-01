Rails.application.routes.draw do


  get 'maps/index'

  get'maps/query' => 'maps#query'

  get '/maps/info' => 'maps#info'

  post '/maps/create' => 'maps#create'
  get 'maps/new' => 'maps#new'

  get 'users/new' => 'users#new'

  get 'front_end_testing/index'





  get 'home' => 'sessions#index'

  get 'home/login' => 'sessions#new'

  post 'sessions' => 'sessions#create'




  post 'users' => 'users#create'

  get 'users/get_user_modal' => 'users#get_user_modal'

  get 'home/register' => 'users#new'

  get 'users/:user_id' => 'users#show'



  post 'listings/search' => 'listings#search'

  get 'listings' => 'listings#index'

  get 'listings/home' => 'listings#index'

  post 'listings/filter' => 'listings#filter'

  get 'listings/new' => 'listings#new'


  post 'properties/new' => 'properties#start_listing'

  get 'properties/new' => 'properties#new'

  get 'properties/:property_id' => 'properties#show'

  post 'properties' => 'properties#create'

  get 'properties/:property_id/edit' => 'properties#edit'

  patch 'properties/:property_id' => 'properties#update'



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
