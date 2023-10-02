
  Rails.application.routes.draw do
    post 'user/ban/:id', to: 'users#ban_user', as: 'admin_ban_user'
    post 'user/unban/:id', to: 'users#unban_user', as: 'admin_unban_user'
    get '/search', to: 'articles#search'
    
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

  root 'home#index'
end
