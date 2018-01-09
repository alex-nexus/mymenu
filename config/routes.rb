Rails3BootstrapDeviseCancan::Application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  resources :users, :only => [:show, :index]

  authenticated :user do
    root :to => 'restaurants#map'
  end

  resources :restaurants, :only => [:show, :index] do
    get 'map', :on => :collection

    #resources :menus
    resources :dishes
  end

  mount Resque::Server, :at => "/resque"
  root :to => 'restaurants#map'
end
