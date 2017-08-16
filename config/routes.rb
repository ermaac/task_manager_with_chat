# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboards#index'
  get 'dashboards/:id', to: 'dashboards#show', as: :dashboard
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  resources :invitations
  resources :boards do
    resources :lists do
      resources :notes
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :profiles, only: [:show, :update, :edit]
  delete 'invitings', to: 'invitings#destroy'
  post 'user_boards', to: 'dashboard#create', as: 'user_boards'
  put '/boards/:board_id/lists/:id/switch_editability', to: 'lists#switch_editability', as: :switch_list_editability
  mount ActionCable.server => '/cable'
end
