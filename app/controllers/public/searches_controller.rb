class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @object = params[:object]
    @word = params[:word]
    @new_post = Post.new
    
    if @object == "User"
      @users = User.searcing(params[:search],params[:word])
    else
      @posts = Post.searcing(params[:search],params[:word])
    end
  end
end
