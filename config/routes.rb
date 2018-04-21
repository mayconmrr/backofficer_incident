Rails.application.routes.draw do
  devise_for :analysts
  devise_for :backofficers

  resources :incidents do
    patch :analyse
    patch :solution
    patch :capture
    patch :pending
    patch :reopen
  end

  get 'my_incidents', to: 'incidents#my_incidents'
  get 'solve', to: 'incidents#solve'
  get 'pending', to: 'incidents#pending'
  get 'search', to: 'incidents#search'
  get 'reopen', to: 'incidents#reopen'

  root 'incidents#index'
end
