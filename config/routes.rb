Rails.application.routes.draw do
  scope module: :user do ## Userルーディング纏め
    root to: 'homes#top' ## topページルーディング
    get   '/about'         => 'homes#about',  as: 'about'            ## aboutページルーディング
    get   '/posts/search'  => 'posts#search', as: 'search'           ## searchページルーディング
    resources :posts, only: [:new, :create, :index, :show, :destroy] ## Postルーディング
    resources :users, only: [:show, :edit, :update]                  ## Userルーディング
  end

  devise_for :users ## Userテーブルルーディング

end
