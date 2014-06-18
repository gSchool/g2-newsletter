Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'pages#index'

  resources :users, :only => [:create, :destroy, :new, :show]
  resources :sessions, :only => [:destroy, :create, :new]
  resources :publications do
    resources :articles, :only => [:new, :create, :show]
  end
  resources :subscriptions, :only => [:index, :create]

  get "forgot_password" => "forgot_password#forgot_password"
  put "forgot_password" => "forgot_password#send_password"

  get "password_reset" => "forgot_password#password_reset"
  put "password_reset" => "forgot_password#change_password"


  get '/logout', to: 'sessions#destroy'
  get '/users/forgot_password', to: 'users#forgot_password'
  get '/terms', to: 'terms#index', :as => 'terms'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view
  #


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
