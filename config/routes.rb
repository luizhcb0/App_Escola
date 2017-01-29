Rails.application.routes.draw do

  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html
  root 'static#index'

  resource :session, only: [:new, :create, :destroy]

  resources :schools
  resources :professors
  # para motrar como uma url child não ser confundida com um ID
  # resources :professors do
  #   get 'send_message', :on => :collection
  #   post 'save_message', :on => :collection
  # end
  #
  resources :students
  resources :classrooms
  resources :messages
  resources :activities
  resources :options
  resources :activity_categories
  resources :reports

end
