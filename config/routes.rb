Rails.application.routes.draw do
  resource :oauth, only: [] do
    member do
      post 'authorize' => 'oauth#authorize'
    end
  end
end
