# frozen_string_literal: true

Rails.application.routes.draw do
  root 'incidents#index'

  devise_for :analysts, controllers: { confirmations: 'confirmations' }
  devise_for :backofficers, controllers: { confirmations: 'confirmations' }

  resources :incidents, shallow: true do
    patch 'analyse'
    patch 'solution'
    patch 'capture'
    patch 'pending'
    patch 'reopen'

    member do
      get 'solve'
      get 'pending'
      get 'reopen'
    end

    collection do
      get 'search'
      get 'my_incidents'
    end
  end
end
