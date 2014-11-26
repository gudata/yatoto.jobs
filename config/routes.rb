Rails.application.routes.draw do
  root 'statics#homepage'


  resources :administrators
  resources :designers

  resources :secrets do
    collection do
      get :header
      get :ajax_1
      get :ajax_2
    end
  end

end
