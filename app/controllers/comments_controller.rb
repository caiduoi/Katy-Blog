class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  
  def create
    @comment = Comment.new comment_params
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Commented!"
      redirect_to @comment.entry
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.entry
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :entry_id)
  end
  
end