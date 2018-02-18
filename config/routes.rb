Rails.application.routes.draw do
  devise_for :analysts
  devise_for :backofficers
  resources :incidents

  get 'incident', to: 'incidents#incident'

  root 'incidents#index'
end
