Rails.application.routes.draw do
  resources :personals#, only: [:info, :edit, :update] do
    #member do
      #get :info
    #end
  #end
  root 'personals#new'
end
