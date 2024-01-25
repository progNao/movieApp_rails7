Rails.application.routes.draw do
  devise_scope :user do
    root :to => 'devise/sessions#new'
  end
  delete '/logout', to: 'devise/sessions#destroy'
  resources :movies
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  patch '/movies/delete/:id' => 'movies#delete_update', as: 'delete_update'
end
