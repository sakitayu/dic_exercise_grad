class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :profile_update]
  before_action :set_user, only: [:show, :edit]

  def index
    if current_user.umbrella
      @users = User.all
    else
      redirect_to starts_path
    end
  end

  def show
  end

  def edit
    if current_user.id != @user.id
      redirect_to users_path
    end
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

  def set_user
    @user = User.find(params[:id])
  end

end
