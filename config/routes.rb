# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  resources :boards
  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
