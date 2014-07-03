Faee::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root :to => 'store#index'
  resources :line_items, only: [:create, :destroy]
  resources :carts, only: [:show, :destroy]
  resources :store, only: [:index, :show]
  resources :orders, only: [:new, :create, :index]

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations:  'registrations' }

  devise_scope :user do
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end

  scope :path => :user do
    resources :addresses
  end

  namespace :admin do
    root :to => 'dashboard#index'
    get 'dashboard', to: 'dashboard#index'
    get 'stats', to: 'stats#index'

    resources :categories, :except => :show do
      collection { match :search, via: [:get,:post], to: 'categories#index' }
    end

    resources :products, :except => :show do
      collection { match :search, via: [:get,:post], to: 'products#index' }
    end
      get 'catalog', to: 'products#pdf'

    resources :settings, :except => :show

    resources :orders do
      match 'ship', to: 'orders#ship', via: [:patch, :put], as: 'ship'
      match 'complete', to: 'orders#complete', via: [:patch, :put], as: 'complete'
      match 'cancel', to: 'orders#cancel', via: [:patch, :put], as: 'cancel'
      match 'resume', to: 'orders#resume', via: [:patch, :put], as: 'resume'
      collection { match :search, via: [:get,:post], to: 'orders#index' }
    end

    resources :pages do 
      collection { post :sort }
    end

    resources :users do
      resources :addresses, :except => :index
      collection { match :search, via: [:get,:post], to: 'users#index' }
    end
  end

  get '*slug', to: 'pages#show'
  resources :pages, path: "", only: [:show]
  
  
end
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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

