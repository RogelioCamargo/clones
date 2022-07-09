Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "subs#index"
	resources :users, only: %i(new create show)
	resource :session, only: %i(new create destroy)
	resources :subs, except: %i(destroy)
	resources :posts, except: %i(index destroy) do
		resources :comments, only: %i(new)
		member do 
			post :upvote 
			post :downvote 
		end
	end
	resources :comments, only: %i(create show) do 
		member do 
			post :upvote 
			post :downvote
		end
	end
end
