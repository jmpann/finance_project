Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  root 'welcome#index'
  get '/etfs/:id', to: 'etfs#show', as: 'etf'
  get '/search', to: 'searches#index', as: 'search'
  get '/search/new', to: 'searches#new', as: 'new_search'
end
