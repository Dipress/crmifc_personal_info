Rails.application.routes.draw do
  resources :personals do
  	collection do
      get :failing
    end
  end
  root 'personals#new'
end
