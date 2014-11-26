Rails.application.routes.draw do
  root 'statics#homepage'


  resources :administrators
  resources :designers

  resources :secrets do
    collection do
      get :header
    end
  end

end
