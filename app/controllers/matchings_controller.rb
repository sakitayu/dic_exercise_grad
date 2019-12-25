class MatchingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:matching][:followed_id])
    current_user.follow!(@user)
  end

  def destroy
    @user = Matching.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
