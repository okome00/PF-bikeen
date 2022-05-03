Rails.application.routes.draw do
  devise_for :users ## Userテーブルルーディング

  scope module: :user do ## Userルーディング纏め
    root to: 'homes#top' ## topページルーディング
    get   '/about'              => 'homes#about',  as: 'about'               ## aboutページルーディング
    get   '/posts/search'       => 'posts#search', as: 'search'              ## searchページルーディング
    get   '/post/hashtag/:name', to: 'posts#hashtag'
    resources :posts, only: [:new, :create, :index, :show, :destroy] do ## Postルーディング
      resources :post_comments, only: [:create, :destroy]               ## PostCommentルーディング
      resource  :favorites,     only: [:create, :destroy]               ## Favoriteルーディング
    end
    resources :users, only: [:show, :edit, :update] do                  ## Userルーディング
      resource :relationships, only: [:create, :destroy]                ## Relationshipモデルルーディング
      get 'followings' => 'relationships#followings', as: 'followings'  ## フォロー一覧ルーディング
      get 'followers'  => 'relationships#followers',  as: 'followers'   ## フォロワー一覧ルーディング
    end
  end

end
