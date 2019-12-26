class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :profile_update]
  before_action :set_user, only: [:show, :edit]
  require "date"

  def index
    if current_user.area != "未入力"
      search_date = Date.today
      @users = User.where(updated_at: search_date.in_time_zone.all_day())
      @q = @users.ransack(params[:q])
      @users = @q.result(distinct: true)
      @matchings = Matching.all
    else
      redirect_to new_start_path
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
    current_user.update(user_params)

    if Matching.where(follower_id:current_user.id)
      relation = Matching.where(follower_id:current_user.id)
      relation.delete_all
      if Matching.where(followed_id:current_user.id)
      relation = Matching.where(followed_id:current_user.id)
      relation.delete_all
      end
    end

    if Matching.where(followed_id:current_user.id)
      relation = Matching.where(followed_id:current_user.id)
      relation.delete_all
    end

    redirect_to users_path
  end

  def profile_update
    current_user.update(profile_params)
      
    redirect_to users_path
  end

  def confirm_request
    @matchings = Matching.all
    @conversations = Conversation.all
  end

  private

  def user_params
    params.require(:user).permit(:have_umbrella, :area, :name, :gender, :age, :introduction)
  end


  def profile_params
    params.require(:user).permit(:name, :gender, :age, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
