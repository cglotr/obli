# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  resources :obligations do
    resources :payments
  end
  root 'obligations#index'
end
