Rails.application.routes.draw do
  root 'statics#homepage'


  resources :administrators
  resources :designers

  resources :secrets do
    collection do
      get :header
      get :ajax_1, via: [ :post, :options, :get]
      get :ajax_2, via: [ :post, :options, :get]
    end
  end

end
