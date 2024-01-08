Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :users
    resources :posts
  end
  
  
  
  
  
  
  
  
end
