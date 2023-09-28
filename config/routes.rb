Rails.application.routes.draw do
  resources :comments
  resources :articles
  resources :categories
  resources :tags
  Rails.application.routes.draw do
  resources :comments
  resources :articles
  resources :categories
  resources :tags
    devise_for :users, path: 'api/auth', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  end

  root 'home#index'
end
