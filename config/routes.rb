Rails.application.routes.draw do
devise_scope :user do
  root to: "users/sessions#new"
end
devise_for :users,:controllers=> {:registrations=>'users/registrations',:sessions=>'users/sessions'}
resources :tickets,:except=>[:destroy] do
  member  do
    get '/status_and_ownership'=>'tickets#status_and_ownership'
    post '/change_status_and_ownership'=>'tickets#change_status_and_ownership'
    get 'staff_reply/new'=>'ticket_replies#new_staff_reply' 
    post 'staff_reply/create'=>'ticket_replies#create_staff_reply'
    get 'customer_reply/new'=>'ticket_replies#new_customer_reply' 
    post 'customer_reply/create'=>'ticket_replies#create_customer_reply'
   
  end
end  
resources :conversations do
  resources :messages
end
get'tickets/:id'=>'tickets#destroy' 
get '/user_dashboard/conversations/:id' => 'conversations#show'
# get '/search_form'=>'tickets#search_form'
# get '/search'=>'tickets#search'
# get 'staff_reply/new'=>'ticket_replies#new_staff_reply' 
# post 'staff_reply/create'=>'ticket_replies#create_staff_reply'
# get 'customer_reply/new'=>'ticket_replies#new_customer_reply' 
# post 'customer_reply/create'=>'ticket_replies#create_customer_reply'

  # root :to => "staffs#new"
  get 'user_dashboard/view' => 'user_dashboards#view'
  get 'admin/user_registrations/new'=>'admin_user_registrations#new'
  post 'admin/user_registrations/new'=>'admin_user_registrations#create'

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
