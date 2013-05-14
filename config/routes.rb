MediaLab::Application.routes.draw do
  devise_for :users

  root to: "landing#index"
  get '/main', to: 'main#index', as: :main
end
