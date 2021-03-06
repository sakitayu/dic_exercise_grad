class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :profile_update, :start]
  before_action :set_user, only: [:show, :edit]
  require "date"

  def index
    if user_signed_in? && current_user.area != nil
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
      
      # 会話ルームがある場合は@roomに会話ルームIDを入れる
      if current_user.have_umbrella == true && current_user.following.present?
        if Conversation.find_by(sender_id: current_user.id, recipient_id: current_user.following.first.id) != nil
          @room = Conversation.find_by(sender_id: current_user.id, recipient_id: current_user.following.first.id)
        end
      elsif current_user.following.present?
        if Conversation.find_by(sender_id: current_user.id, recipient_id: current_user.following.first.id) != nil
          @room = Conversation.find_by(sender_id: current_user.following.first.id, recipient_id: current_user.id)
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  def show
    if user_signed_in? &&  current_user.area == nil
      redirect_to new_user_session_path
    end
    
    # Matchingテーブルから表示ユーザーがリクエストを送っているユーザーを@followedに格納
    @matchings = Matching.all
    @matchings.each do |matching|
      if current_user.id == User.find(matching.followed_id).id
        @follower = User.find(matching.follower_id)
        @followed = User.find(matching.followed_id)
      end
    end

    # 会話ルームがある場合は@roomに会話ルームIDを入れる
    if current_user.have_umbrella == true && current_user.following.present?
      if Conversation.find_by(sender_id: current_user.id, recipient_id: current_user.following.first.id) != nil
        @room = Conversation.find_by(sender_id: current_user.id, recipient_id: current_user.following.first.id)
      end
    elsif current_user.following.present?
      if Conversation.find_by(sender_id: current_user.id, recipient_id: current_user.following.first.id) != nil
        @room = Conversation.find_by(sender_id: current_user.following.first.id, recipient_id: current_user.id)
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
    
    if params[:follow_state] == {"true"=>""}
      if @user.update(user_params)
        redirect_to user_path(id: current_user.id)
      else
        render :edit
      end
    # params[:user][:state]が"start"の状態でlink_toからきた処理をここで行う
    elsif params[:user][:state] == "start"
      current_user.update(state: "start")
      redirect_to user_path(current_user.id)
    # params[:user][:state]が"restart"の状態でlink_toからきた処理をここで行う (スタート画面から始めるからのリンク)
    elsif params[:user][:state] == "restart"
      @user.update(state: "restart")
      if current_user.have_umbrella == true && Matching.where(follower_id: current_user.id).any?
        #傘もちユーザーをフォロしているMarchingを全て取得してoverlap_usersに格納
        overlap_users = Matching.where(followed_id: current_user.id)
        # 傘持ちユーザーがスタート画面に移動した場合に自身をフォローしているユーザー全てのフォローを解除して
        # 同時に彼らのstateをbrokenにする
        overlap_users.each do | overlap_user |
          if overlap_user.follower_id != @user.id
            User.find_by(id: overlap_user.follower_id).update(state: "broken")
            overlap_user.destroy
          end
        end
        # さらに傘持ちユーザー自身のフォローも解除する
        # 傘持ちユーザーがフォロー状態(follower_idに存在する)のMatchingを削除
        current_user_following = Matching.find_by(follower_id: current_user.id)
        current_user_following.destroy
      # 傘なしユーザーがスタート画面に移動した場合に傘持ちユーザーへのフォローを解除する
      elsif current_user.have_umbrella == false && Matching.find_by(follower_id: current_user.id)
        # ban_removingをtrueにすることでAction Cableのremove.coffeeで傘もちユーザーのユーザー一覧から削除できる
        current_user.update(removing: true)
        matching_state = Matching.find_by(follower_id: current_user.id)
        matching_state.destroy
        # 相互フォロー状態の時は傘もちユーザーがから傘なしユーザーへのフォローも解除する
        if Matching.find_by(followed_id: current_user.id)
          # 相手の傘もちユーザーのstateをmessageからbrokenに変更する
          current_user.followers.first.update(state: "broken")
          addon_matching_state = Matching.find_by(followed_id: current_user.id)
          addon_matching_state.destroy
        end
      end
      redirect_to start_users_path
    # リクエスト確認画面から「お願いする」ボタンをクリックしたらメッセージ画面に遷移する
    elsif params[:user][:state] == "message"
      current_user.update(state: "message")
      room = Conversation.find_by(sender_id: current_user.following.first.id, recipient_id: current_user.id)
      redirect_to conversation_messages_path(room.id)
    else
      #スタート画面でユーザー情報を更新したらフォロー関係がリセットされる
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
  end

  def start
    if current_user.state == "message" && user_signed_in?
      # メッセージ中の時にウィンドウを再び開いた場合にroomに会話テーブルの中身を入れます
      # 傘もちユーザーの場合はsender_idがcurrent_userになるので sender_id: current_user.id でfind_byする
      if current_user.have_umbrella == true
        room = Conversation.find_by(sender_id: current_user.id, recipient_id: current_user.following.first.id)
      else
        room = Conversation.find_by(sender_id: current_user.following.first.id, recipient_id: current_user.id)
      end
      redirect_to conversation_messages_path(room.id)
    # 状態がリクエスト中もしくはメッセージ中の場合はindex(ユーザー一覧ページ)に移動するようにする
    elsif current_user.following.first.present? && user_signed_in?
      # メッセージ中の時にウィンドウを再び開いた場合にroomに会話テーブルの中身を入れます
      # 傘もちユーザーの場合はsender_idがcurrent_userになるので sender_id: current_user.id でfind_byする
      if current_user.have_umbrella == true
        room = Conversation.find_by(sender_id: current_user.id, recipient_id: current_user.following.first.id)
      else
        room = Conversation.find_by(sender_id: current_user.following.first.id, recipient_id: current_user.id)
      end
      redirect_to users_path
    # 傘もちユーザーの場合、相手からリクエストがきている場合はindex(ユーザー一覧ページ)に移動するようにする
    elsif current_user.followers.first.present? && user_signed_in?
      redirect_to users_path
    else
      @user = User.find(current_user.id)
    end
  end

  def profile_update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(id: current_user.id)
    else
      render :edit
    end
  end

  def confirm_request
    @matchings = Matching.all
    @conversations = Conversation.all
    if current_user.state == "message"
      redirect_to user_path(id: current_user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:have_umbrella, :area, :name, :gender, :age, :introduction, :image, :image_cache, :removing, :state)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
