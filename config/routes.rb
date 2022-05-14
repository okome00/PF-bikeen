Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {                                     ## Userテーブルルーディング
    registrations: "user/registrations",
    sessions:      "user/sessions"
}
  scope module: :user do                                                ## Userルーディング纏め
    root to: 'homes#top'                                                ## topページルーディング
    get   '/posts/search'       => 'posts#search', as: 'search'         ## searchページルーディング
    get   '/post/hashtag/:name' => 'posts#hashtag'                      ## hashtagページルーディング
    get   '/post/hashtag'       => 'posts#hashtag'
    resources :posts, only: [:new, :create, :index, :show, :destroy] do ## Postルーディング
      resources :post_comments, only: [:create, :destroy]               ## PostCommentルーディング
      resource  :favorites,     only: [:create, :destroy]               ## Favoriteルーディング
    end
    resources :users, only: [:show, :edit, :update] do                  ## Userルーディング
      resource :relationships, only: [:create, :destroy]                ## Relationshipルーディング
      get 'followings' => 'relationships#followings', as: 'followings'  ## フォロー一覧ルーディング
      get 'followers'  => 'relationships#followers',  as: 'followers'   ## フォロワー一覧ルーディング
    end
    resources :notifications, only: [:index]                            ## Notificationルーディング
  end
end
