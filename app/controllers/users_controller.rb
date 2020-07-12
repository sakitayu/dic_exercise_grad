class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :profile_update, :start]
  before_action :set_user, only: [:show, :edit]
  require "date"

  def index
    if current_user.area != nil
      search_date = Date.today
      # ポートフォリオ用に一時的に直近滞在時間表示機能をオフにしています
      # 直近滞在時間表示機能をオンにする場合は以下のコードに変えてください
      #
      # @users = User.all
      #      ↓↓↓↓↓↓
      # @users = User.where(updated_at: search_date.in_time_zone.all_day())
      @users = User.all
      @q = @users.ransack(params[:q])
      @users = @q.result(distinct: true)
      @matchings = Matching.all
    else
      redirect_to start_users_path
    end
  end

  def show
    if current_user.area == nil
      redirect_to start_users_path
    end
    #Matchingテーブルから表示ユーザーがリクエストを送っているユーザーを@followedに格納
    @matchings = Matching.all
    @matchings.each do |matching|
      if current_user.id == User.find(matching.followed_id).id
        @follower = User.find(matching.follower_id)
        @followed = User.find(matching.followed_id)
      end
    end
  end

  def edit
    if current_user.id != @user.id
      redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
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
    else
      render 'start'
    end
  end

  def start
    @user = User.find(current_user.id)
  end

  def profile_update
    @user = User.find(current_user.id)
    #binding.pry
    if @user.update(user_params)
      #binding.pry
      redirect_to user_path(id: current_user.id)
    else
      render :edit
    end
  end

  def confirm_request
    @matchings = Matching.all
    @conversations = Conversation.all
  end

  private

  def user_params
    params.require(:user).permit(:have_umbrella, :area, :name, :gender, :age, :introduction, :image, :image_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
