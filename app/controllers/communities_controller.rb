class CommunitiesController < ApplicationController
  before_action :set_community, only: [ :show ]

  def index
    @communities = policy_scope(Community)
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
