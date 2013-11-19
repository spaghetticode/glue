Glue::Application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  devise_for :players

  resource :profile, :only => [:edit, :update, :show]
end
