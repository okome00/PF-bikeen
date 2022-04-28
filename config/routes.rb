Rails.application.routes.draw do
  devise_for :users ## Userテーブルルーディング

  scope module: :user do ## Userルーディング纏め
    root to: 'homes#top' ## topページルーディング
    get   '/about'         => 'homes#about',  as: 'about'               ## aboutページルーディング
    get   '/posts/search'  => 'posts#search', as: 'search'              ## searchページルーディング
    resources :posts, only: [:new, :create, :index, :show, :destroy] do ## Postルーディング
      resources :post_comments, only: [:create]                         ## PostCommentルーディング
    end
    resources :users, only: [:show, :edit, :update]                     ## Userルーディング
  end

end
