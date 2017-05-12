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
  resources :students do
    resources :reports, except: [:new, :create], param: :date
  end
  resources :reports, only: [:new, :create] do
    post 'search', on: :collection
    post 'send_all', on: :collection
    post 'send_clip', on: :collection
  end

  resources :classrooms
  resources :messages
  resources :activities
  resources :options
  resources :activity_categories
  # resources :reports do
  #   post 'search', on: :collection
  # end

  post '/read/', to: 'message_students#read', as: 'read'

  patch '/set_presence/:id/:status', to: 'students#set_presence', as: 'set_presence'
  
  namespace :api do
    namespace :v1 do
      resources :students
    end
  end

end
