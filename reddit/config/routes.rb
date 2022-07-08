Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "subs#index"
	resources :users, only: %i(new create show)
	resource :session, only: %i(new create destroy)
	resources :subs, expect: %i(destroy)
end
