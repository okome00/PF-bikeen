Rails.application.routes.draw do
  namespace :user do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
  end
  devise_for :users ## Userテーブルルーディング

  scope module: :user do ## Userルーディング纏め
    root to: 'homes#top' ## topページルーディング
    get '/about' => 'homes#about', as: 'about' ## aboutページルーディング
    get '/posts/search' => 'posts#search', as: 'search' ## searchページルーディング
    resources :posts, only: [:new, :create, :index, :show, :destroy] ## Postルーディング
  end

end
