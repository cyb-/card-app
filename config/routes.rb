Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, defaults: { format: :json } do

      resources :players, only: [:index, :show] do
        resources :cards, only: [:index], controller: "players/cards"
        resources :games, only: [:index], controller: "players/games"
      end

      resources :cards, only: [:index, :show]

      resources :games, only: [:index, :create, :show] do
        resource  :winner, only: [:show],           controller: "games/winner"
        resources :fights, only: [:index, :create], controller: "games/fights"
      end

    end
  end

  root "main#index"

end
