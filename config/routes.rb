# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
    controllers: {},
    path: '',
    path_names: { sign_in: "signin", sign_up: "signup" }
  get 'welcome/index'
  resources :obligations do
    resources :payments
  end
  root 'obligations#index'
end
