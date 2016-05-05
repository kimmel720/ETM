Rails.application.routes.draw do

  resources :panoramas, only: [:new, :create, :show, :edit, :update] do

    member do
      get 'transition' => 'panoramas#transition'
      post 'add_art/:art_id' => 'panoramas#add_artwork'
      post 'add_pan/:adj_id' => 'panoramas#add_adjacent_panorama'
    end
  end

  get 'search/results'

  resources :museum_users
  # admin page is broken right now
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  resources :users
  post '/addContent' => 'users#addContent'
  root 'museums#index'

  # could pull artworks out and redirect instead of nesting
  # this would make sense if we are seperating art as a resource
  # from exhibition
  # resources :artworks

  resources :museums do
    resources :exhibitions do
      member do
        get 'floor_plan'
        get 'edit_floor_plan'
        get 'resources'
      end
    end
  end
  resources :artworks
  resources :artists

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
