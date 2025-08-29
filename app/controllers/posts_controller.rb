class PostsController < ApplicationController
before_action :set_post, only: [ :show, :edit, :update, :destroy ]
before_action :set_community, only: [:index, :new, :create, :show]

  def index
    @posts = policy_scope(Post)
  end

  def show
    @comments = @post.comments.includes(:user).order(created_at: :asc)
    @comment = Comment.new
    authorize @post

  end

  def new
    @post = @community.posts.build
    authorize @post
  end

  def create
    @post = @community.posts.build(post_params)
    @post.user = current_user
    authorize @post
    if @post.save
      redirect_to community_path(@community)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted.", status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_community
    @community = Community.find_by(id: params[:community_id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :community_id)
  end
end
