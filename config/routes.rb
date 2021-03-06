MediaLab::Application.routes.draw do
  devise_for :users

  root to: "landing#index"
  get '/main', to: 'main#index', as: :main

  resources :places, :only => [:index, :show]

  namespace :owner do
    resources :places
  end

  namespace :organizer do
    resources :events
  end

end
