# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  namespace :api do
    namespace :v1 do
      resources :abouts, only: %i[index show update]
    end
  end
  devise_for :users, defaults: { format: :json }, controllers: { sessions: "sessions" }
end
