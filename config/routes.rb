Rails.application.routes.draw do
  get 'home/index'
  resources :movies, only: %i[index show]
  resources :production_companies, only: %i[index show]
end
