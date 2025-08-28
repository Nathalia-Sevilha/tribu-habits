class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    authorize @user
  end

  def update
    @user = current_user
    authorize @user

    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :show, alert: "There was an error updating your profile."
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :photo)
  end
end
