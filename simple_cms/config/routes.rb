Rails.application.routes.draw do

#  get 'subjects/index'

#  get 'subjects/show'

#  get 'subjects/edit'

#  get 'subjects/delete'

  get 'demo/escape_output'
   #match ':controller(/:action(:/id))', via: :get

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'public#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  get 'show/:permalink', to: 'public#show'
  get 'admin', to: 'access#index'


  resources :subjects, :pages, :sections, :demo, :admin_users
  resources :public, only: [:index, :show]
  resources :access do
    collection do
      get 'logout'
      get 'login'
      post 'attempt_login'
    end
  end

  # =========================================================================== 
  # # map access controller to /admin path 
  # # It will also create the logout_admin_url and logout_admin_path route helpers.
  #    resources :access, path: '/admin' do
  #       collection do
  #         get 'logout'
  #       end
  #     end
  # ===========================================================================

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
