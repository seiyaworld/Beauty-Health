class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.all
    @new_post = Post.new
  end

  def show
    @new_post = Post.new
    @post = Post.find(params[:id])
  end

  def edit
    @new_post = Post.new
    @post = Post.find(params[:id])
  end
  
  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to posts_path
    else
      @posts = Post.all
      @new_post = post
      render :index
    end
  end
  
  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = "更新に成功しました"
      redirect_to posts_path
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
    
  private
  
 def post_params
   params.require(:post).permit(:title,:body,:image)
 end
  
end
