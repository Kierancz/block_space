BlockSpace::Application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  devise_scope :users do
    get "signup",           to: "devise/registrations#new"
    get "/users/:id",       to: "users#show"
  end
  resources :users #, :only => [:show]
  resources :space do
    resources :blocks
  end
  
  root 'pages#home'
  match '/space/:space_id/blocks/:id',  to: 'blocks#destroy',           via: 'delete'
  match '/space/:space_id/blocks/:id/insert',  to: 'blocks#insert',     via: 'get'
  match '/spaces',                     to: 'space#index',              via: 'get'
  match '/spaces',                     to: 'space#create',             via: 'post'
  match '/spaces/:id/destroy',         to: 'space#destroy',            via: 'delete'
  match '/spaces/removecollaborator',  to: 'space#removecollaborator', via: 'get'
  match '/space/:id/edit',              to: 'space#edit',               via: 'post'
  match '/help',                        to: 'pages#help',               via: 'get'
  match '/about',                       to: 'pages#about',              via: 'get'
  match '/contact',                     to: 'pages#contact',            via: 'get'
  match '/uploader',                    to: 'uploader#create',          via: 'post'
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
