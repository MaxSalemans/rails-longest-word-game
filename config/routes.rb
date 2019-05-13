Rails.application.routes.draw do
  get 'new', to: 'games#new', as: :new
  post 'score', to: 'games#score', as: :score
  get 'score', to: 'games#new' # when page refresh, goes back to game start page
end
