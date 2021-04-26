Rails.application.routes.draw do
  resource :oauth, only: [] do
    member do
      get 'authorize' => 'oauth#authorize'
    end
  end
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
