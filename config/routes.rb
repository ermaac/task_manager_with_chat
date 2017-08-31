# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'dashboards#index'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  resources :dashboards
  resources :invitations
  resources :invited_user_permissions, only: [:update]
  resources :boards do
    resources :lists do
      resources :notes
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'registrations' }
  resources :profiles, only: [:show, :update, :edit]
  post 'user_boards', to: 'dashboards#create', as: 'user_boards'
  patch '/boards/:board_id/lists/:list_id/notes/:id/move', to: 'notes#move', as: :move
  patch '/notes/:board_id/:list_id/:note_id', to: 'notes#update_drop', as: :update_drop
  put '/boards/:board_id/lists/:id/switch_editability', to: 'lists#switch_editability', as: :switch_list_editability
  get '/lists/:id/allowed_actions', to: 'lists#allowed_actions', as: :list_allowed_actions
  get '/dashboards/:id/users/:user_id/join_user', to: 'dashboards#join_user'
  mount ActionCable.server => '/cable'
end
