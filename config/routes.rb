Rails.application.routes.draw do
  root 'statics#homepage'


  resources :administrators
  resources :designers


  controller :secrets, path: '/secrets' do
    match 'header', via: [:post, :options, :get]
    match 'ajax_1', via: [:post, :options, :get]
    match 'ajax_2', via: [:post, :options, :get]
  end

end
