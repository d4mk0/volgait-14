Rails.application.routes.draw do
  
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :questions do
    get :new_draft, on: :collection
    post :create_draft, on: :collection
    get :publish, on: :member
    get :solved, on: :member
    
    get :rate_up, on: :member
    get :rate_down, on: :member
		resources :answers do
      get :rate_up, on: :member
    end
	end
  
  get '/manage' => 'manage#index'


	root to: 'questions#index'
end
