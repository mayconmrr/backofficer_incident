Rails.application.routes.draw do
  devise_for :analysts
  devise_for :backofficers

  resources :incidents do
    patch :analyse
    patch :solve
    patch :capture
  end

  get 'my_incidents', to: 'incidents#my_incidents'
  get 'solve_form', to: 'incidents#solve_form'
  root 'incidents#index'
end
