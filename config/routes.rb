Rails.application.routes.draw do
  root 'groups#index'
  resources :groups, only:[:index] do
    resources :messages, only:[:index]
  end
end
