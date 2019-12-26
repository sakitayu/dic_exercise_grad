class StartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
  end

  def new
    @user = User.find(current_user.id)
  end

  def create
    redirect_to users_path
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:have_umbrella, :area, :name, :gender, :age)
  end
  
end
