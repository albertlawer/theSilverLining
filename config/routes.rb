Rails.application.routes.draw do
  
  
  
  resources :permissions_roles
  resources :permissions
  resources :roles
  get 'request_masters_admin' => "request_masters#request_masters_admin", as: :request_masters_admin
  get 'payment_tables_admin' => "payment_tables#payment_tables_admin", as: :payment_tables_admin
  get 'investment_masters_admin' => "investment_masters#investment_masters_admin", as: :investment_masters_admin

  
  post 'amfp_callback' => "callbacks#amfp_callback", as: :amfp_callback
  
  authenticated :user do
    root :to => 'home#dashboard', as: :authenticated_root
  end

  root :to => 'home#index'

  devise_scope :user do
     get "/login", :to => "devise/sessions#new", as: :login # Add a custom sign in route for user sign in
     delete "/logout", :to => "devise/sessions#destroy" # Add a custom sing out route for user sign out
     get "/register", :to => "devise/registrations#new", as: :register # Add a Custom Route for Registrations
  end
  
  devise_for :users
  resources :request_masters
  resources :payment_tables
  resources :referals_masters
  resources :investment_masters
  resources :account_masters
  resources :system_configs
end
