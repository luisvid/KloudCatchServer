Kloudcatch::Application.routes.draw do
  resources :droplets
  get '/synch/:id' => 'droplets#synch'
  get '/confirm/:id' => 'droplets#confirm'
  get '/pending' => 'droplets#pending'
  post '/upload' => 'droplets#upload'
  
  match '/subscribe' => 'users#subscribe', :via => :post
  match '/unsubscribe' => 'users#unsubscribe', :via => :delete

  match '/login' => 'sessions#login'
  match '/logout' => 'sessions#logout'
end
