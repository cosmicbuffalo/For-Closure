Rails.application.routes.draw do









  get 'front_end_testing/index'





  get 'home' => 'sessions#index' #home page with search bar selector

  # get 'sessions/new' => 'sessions#new' #get modal partial set to login tab

  post 'sessions/location' => 'sessions#set_user_coords'

  post 'sessions' => 'sessions#create' #login method

  get 'logout' => 'sessions#destroy' #logout method


  get 'users' => 'users#dashboard' #user dashboard

  post 'users' => 'users#create' #register method

  get 'users/get_user_modal' => 'users#get_user_modal' #used to get user modal for either login or register with flash errors

  get 'users/new' => 'users#new' #get modal partial set to register tab

  get 'users/:user_id' => 'users#show' #might need to take this out, ideally we should be able to view sellers' profiles and see the properties they've listed



  get'/query' => 'listings#query'

  get 'listings' => 'listings#index'


  post 'listings/search' => 'listings#search' #search bar's action method


  get 'listings/query' => 'listings#query' #get partial for listing details

  get 'listings' => 'listings#index' #main map view

  get 'listings/info' => 'listings#info'

  post 'listings/partial_search' => 'listings#partial_search'

  post 'listings/filter' => 'listings#filter' #soon to be method to filter search results, might not be ajaxified yet

  post 'listings/create' => 'listings#create' #are we even using this?

  get 'listings/new' => 'listings#new' #first page for listing, decides if by owner or by agent based on user, owner if no user is logged in


  post 'properties/test' => 'properties#test'

  post 'properties/new' => 'properties#start_listing' #post destination from listings/new page, saves listing in progress in session and redirects to properties/new

  get 'properties/new' => 'properties#new' #property/listing creation details page, so many checkboxes

  get 'properties/:property_id' => 'properties#show' # property show? is this in a partial already?

  post 'properties' => 'properties#create' #property creation method for form on properties/new page

  get 'properties/:property_id/edit' => 'properties#edit' #need to implement property edit page

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
