# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '',
    controllers: { sessions: :sessions },
    path_names: { sign_in: :signin }
  get 'welcome/index'
  resources :obligations do
    resources :payments
  end
  root 'obligations#index'
end
