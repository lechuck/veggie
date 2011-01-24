Veggie::Application.routes.draw do


  get "tag_autocomplete_searches/Index"

  resources :restaurants do
    # This will also create routing helpers such as restaurant_portions_url and edit_restaurant_portion_path. 
    resources :portions, :except => [:index, :show]
    resources :ratings, :except => [:index, :show]
    resources :comments, :except => [:index, :show, :update] do
      put :delete, :on => :member
    end
    
    collection do
      get :tag
    end
    member do
      get 'add_tags'
      get 'like'
    end
   
  end

  resources :users, :user_sessions, :dashboard 
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  match 'change_city' => 'application#change_city', :as => :change_city
  
  #match 'add_tags' => 'restaurant#add_tags', :as => :add_tags
  #match ':restaurants/:id/add_tags' => 'restaurant#add_tags', :as => :add_tags
  
  #resources :tag_autocomplete_searches, :only => [:index], :as => 'tagautocomplete'
  match 'tagautocomplete' => 'tag_autocomplete_searches#index', :as => :tagautocomplete
    
  root :to => 'dashboard#index', :as => 'dashboard'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)


  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
