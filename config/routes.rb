Rails.application.routes.draw do
  resources :pages, except: [:show]

  get "/pages/:permalink" => "pages#permalink", as: :permalink

  resources :movies, only: %i[index show] do
    collection do
      get "search"
    end
  end

  resources :production_companies, only: %i[index show]

  root to: "home#index"
end
