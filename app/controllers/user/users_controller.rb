class User::UsersController < ApplicationController
  before_action :authenticate_user! ## ログイン権限

  def show ## 会員情報画面表示アクション
    @user = current_user
    @posts = @user.posts
  end

  def edit ## 会員情報編集画面表示アクション
    @user = current_user
  end

  def update ## 会員情報編集アクション
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private ## 会員情報データストロングパラメータ

  def user_params
    params.require(:user).permit(:name, :bike_model, :introduction, :residence, :email)
  end

end
