class CommunitiesController < ApplicationController
  def show
    @community = Community.find(params[:id])
    authorize @community
  end
end
