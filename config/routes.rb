# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboards#index'
  get 'dashboards/:id', to: 'dashboards#show', as: :dashboard
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  resources :invitations
  resources :boards, shallow: true do
    resources :lists, shallow: true do
      resources :notes
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  post 'user_boards', to: 'dashboards#create', as: 'user_boards'
  put 'lists/:id/switch_editability', to: 'lists#switch_editability', as: :switch_list_editability
end
