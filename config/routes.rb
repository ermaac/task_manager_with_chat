# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboards#index'
  get 'dashboards/:id', to: 'dashboards#show', as: :dashboard
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  resources :boards, :lists, :notes, :invitations
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  delete 'invitings', to: 'invitings#destroy'
  post 'user_boards', to: 'dashboards#create', as: 'user_boards'
  get 'lists/:id/switch_editability', to: 'lists#switch_editability', as: :switch_list_editability
end
