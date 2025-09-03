class CommunitiesController < ApplicationController
  before_action :set_community, only: [ :show ]

  def index
    @communities = policy_scope(Community)
    @user_communities = @communities.select { |c| c.users.include?(current_user) }
  end


  def show
    authorize @community
    @posts = Post.where(community: @community).order(created_at: :desc)
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end
end
