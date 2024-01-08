class Public::CommentsController < ApplicationController
  
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    @comment.save
    @new_comment = Comment.new
    @comments = current_user.comments
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    @new_comment = Comment.new
    @comments = current_user.comments
  end
  
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
  
end
