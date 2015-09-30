Rails.application.routes.draw do
  root 'statics#homepage'


  resources :administrators
  resources :designers

  # https://github.com/cyu/rack-cors
  controller :secrets, path: '/secrets' do
    match 'header', via: [  :post, :options, :get]
    match 'ajax_1', via: [:post, :options, :get],  as: 'ajax_1_secrets'
    match 'ajax_2', via: [:post, :options, :get],  as: 'ajax_2_secrets'
  end

end
