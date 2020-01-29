class UsersController < ApplicationController

  before_action :authenticate
  def authenticate
    redirect_to new_user_session_path unless user_signed_in?
  end

	before_action :correct_user, only: [:update, :edit]
  #url直接防止 メソッドを自己定義してbefore_actionで発動。
  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user.id == @user.id
  end

  def create
    @book = Book.new
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book), notice: "You have created book successfully."
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     redirect_to user_path(current_user), notice: "successfully updated user!"
    else
      render "edit"
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end