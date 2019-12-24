class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :profile_update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def profile_update
    if current_user.profile
      current_user.profile.update(profile_params)
    else
      profile_info = current_user.build_profile(profile_params)
      profile_info.save
    end

    redirect_to users_path
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :gender, :age, :introduction)
  end

end
