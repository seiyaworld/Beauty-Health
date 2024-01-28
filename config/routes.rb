Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get "search" => "searches#search"
    resources :users do
 	    resource :relationships, only: [:create, :destroy]
		    # フォローしている人一覧ページ
		    get "followings" => "relationships#followings", as: "followings"
		    # フォローされている人一覧ページ
		    get "followers" => "relationships#followers", as: "followers"     
    end
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end
  end

  
end
