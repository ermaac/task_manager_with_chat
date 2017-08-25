# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboards#index'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  resources :dashboards
  resources :invitations
  resources :boards do
    resources :lists do
      resources :notes
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'registrations' }
  resources :profiles, only: [:show, :update, :edit]
  delete 'invitings', to: 'invitings#destroy'
  post 'user_boards', to: 'dashboards#create', as: 'user_boards'
  patch '/boards/:board_id/lists/:list_id/notes/:id/move', to: 'notes#move', as: :move
  put '/boards/:board_id/lists/:id/switch_editability', to: 'lists#switch_editability', as: :switch_list_editability
  get '/lists/:id/allowed_actions', to: 'lists#allowed_actions', as: :list_allowed_actions
  mount ActionCable.server => '/cable'
end
