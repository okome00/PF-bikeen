Rails.application.routes.draw do
  devise_for :users ## Userテーブルルーディング

  scope module: :user do ## Userルーディング纏め
    root to: 'homes#top' ## topページルーディング
    get '/about' => 'homes#about', as: 'about' ## aboutページルーディング
  end


end
