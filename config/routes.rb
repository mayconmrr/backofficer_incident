Rails.application.routes.draw do
  devise_for :analysts
  devise_for :backofficers
  resources :incidents
end
