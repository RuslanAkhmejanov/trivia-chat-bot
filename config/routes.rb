Rails.application.routes.draw do
  # get 'bot/index'
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "start_game", to: "bot#start_game", as: :start_game
  post "stop_game", to: "bot#stop_game", as: :stop_game
  post "submit_answer", to: "bot#submit_answer", as: :submit_answer

  # Defines the root path route ("/")
  root "bot#home"
end
