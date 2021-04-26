Rails.application.routes.draw do
  resource :oauth, only: [] do
    member do
      get 'authorize' => 'oauth#authorize'
      patch 'authorize' => 'oauth#grant_authorization'
      post 'token' => 'oauth#grant_token'
    end
  end
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
