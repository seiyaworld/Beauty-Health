class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  
  def index
    @user = current_user
    @users = User.all
    @new_post = Post.new
  end

  def show
    @user = User.find(params[:id])
    @new_post = Post.new
  end

  def edit
    @user = User.find(params[:id])
    @new_post = Post.new
    if @user.id != current_user.id
      redirect_to users_path
    end
  end
  
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "更新に成功しました"
      redirect_to user_path(user.id)
    else
      render edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
  
end
