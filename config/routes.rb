Rails.application.routes.draw do
  resource :oauth, only: [] do
    member do
      post 'authorize' => 'oauth#authorize'
      post 'login' => 'oauth#login'
    end
  end
end
