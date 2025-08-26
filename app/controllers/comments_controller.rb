class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: :create

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'comment was successfully created.'
    else
      @comments = @post.comments.includes(:user).order(created_at: :asc)
      flash.now[:alert] = "Could not create the comment."
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment was deleted."
  end


  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
