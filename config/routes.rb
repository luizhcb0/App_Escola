Rails.application.routes.draw do

  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]

  resources :schools
  resources :professors do
    get 'send_message', :on => :collection
    post 'save_message', :on => :collection
  end
  resources :students
  resources :classrooms

end
