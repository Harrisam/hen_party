HenParty::Application.routes.draw do

  root to: "welcome#homepage"

  devise_for :users, :skip => [:registrations]
  # manually add some registration routes
  as :user do
    get 'users/cancel' => 'devise/registrations#cancel', :as => 'cancel_user_registration'
    # skip create
    # skip new (i.e. 'users/sign_up')
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'devise/registrations#update'
    put 'users' => 'devise/registrations#update'
    delete 'users' => 'devise/registrations#destroy'
  end
  
  resources :parties
  get 'parties/:id/invitation' => 'parties#invitation', :as => 'party_invitation'
  post 'parties/:id/send_invitations' => 'parties#send_invitations', :as => 'send_party_invitations'
  get 'parties/join/:token' => 'parties#join', :as => 'join_party'
  post 'parties/join/:token' => 'parties#save_response', :as => 'save_party_response'
  get 'parties/:id/plan' => 'parties#plan', :as => 'plan_party'
  post 'parties/:id/plan' => 'parties#product_search', :as => 'products_to_plan_party'


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
