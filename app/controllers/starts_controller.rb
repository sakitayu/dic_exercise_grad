class StartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
  end

  def new
    # @start = User.find(current_user.id)
    # @start = @start.build_umbrella
    if current_user.umbrella
      @umbrella = current_user.umbrella
    else
      @umbrella = Umbrella.new
    end
  end

  def create
    # umbrella = current_user.build_umbrella(have_umbrella: true)
    # umbrella.save
    # @user = User.find(current_user.id)
    # @user = User.find(current_user.id)
    # @user.save!
    redirect_to users_path
  end

  def update
    @user = User.find(current_user.id)
    @user.update!(user_params)
    redirect_to user_path(@user)
  rescue
    render action: 'index'
  end

  def miracle
    
    if current_user.location
      current_user.location.update(location_params)
    else
      location_info = current_user.build_location(location_params)
      location_info.save
    end
    if current_user.umbrella
      current_user.umbrella.update(umbrella_params)
    else
      umbrella_info = current_user.build_umbrella(umbrella_params)
      umbrella_info.save
    end

    redirect_to users_path
  end

  private

  def umbrella_params
    params.require(:umbrella).permit(:have_umbrella)
  end

  def location_params
    params.require(:location).permit(:area)
  end
end
