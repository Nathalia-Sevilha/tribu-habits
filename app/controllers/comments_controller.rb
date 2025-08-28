class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: :create
  before_action :set_context, only: [:new, :create, :destroy]

  skip_after_action :verify_authorized, only: [:new, :create, :destroy]

  def new
    @comment   = @post.comments.build
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to community_post_path(@community, @post)
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

   def set_context
    @community = Community.find(params[:community_id])
    @post      = @community.posts.find(params[:post_id]) # ensures nesting is consistent
  end
end
