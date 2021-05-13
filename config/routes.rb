Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'texts#index'
  resources :texts, only: [:index]
  get '/paraphrase', to: "texts#rewrite_text"
  get '/show-texts', to: "texts#show_texts"
  get 'delete-texts', to: "texts#delete_texts"
end
