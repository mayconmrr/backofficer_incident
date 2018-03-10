Rails.application.routes.draw do
  devise_for :analysts
  devise_for :backofficers
  resources :incidents

  get 'my_incidents', to: 'incidents#my_incidents'

  root 'incidents#index'
end
