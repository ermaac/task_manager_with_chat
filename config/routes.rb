# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  resources :boards, :lists, :invitings
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  delete 'invitings', to: 'invitings#destroy'
end
