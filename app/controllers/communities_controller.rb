class CommunitiesController < ApplicationController
  before_action :set_community, only: [ :index, :show ]

  def index
    @communities = policy_scope(Community)
  end


  def show
    authorize @community
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end
end
