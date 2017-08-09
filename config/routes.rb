# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboard#index'
  get 'dashboard/:id', to: 'dashboard#show', as: :dashboard
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  resources :boards, :lists, :notes, :invitations
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  delete 'invitings', to: 'invitings#destroy'
  post 'user_boards', to: 'dashboard#create', as: 'user_boards'
end
