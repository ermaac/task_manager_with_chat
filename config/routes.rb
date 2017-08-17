# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  post 'user_boards', to: 'dashboards#create', as: 'user_boards'
  put '/boards/:board_id/lists/:id/switch_editability', to: 'lists#switch_editability', as: :switch_list_editability
  mount ActionCable.server => '/cable'
end
