Glue::Application.routes.draw do
  root to: 'matches#show'

  devise_for :registered_players

  resource :profile, :only => [:edit, :update, :show]
  resource :match,   :only => [:show]
end
