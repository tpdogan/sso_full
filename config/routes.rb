Rails.application.routes.draw do
  resource :oauth, only: [] do
    member do
      post 'authorize' => 'oauth#authorize'
      post 'login' => 'oauth#login'
    end
  end
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
