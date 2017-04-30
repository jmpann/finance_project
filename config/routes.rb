Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get 'my_etfs', to: 'users#my_etfs'
  get 'search_etfs', to: 'etfs#search'
  get '/etfs/:id', to: 'etfs#show', as: 'etf'
end
