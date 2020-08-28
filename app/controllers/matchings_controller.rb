class MatchingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:matching][:followed_id])

    # 傘もちユーザーが傘なしユーザーをフォローする場合は"承認"になるので
    # その場合にstateカラムをmessageにする
    if current_user.have_umbrella == true
      current_user.update(state: "message")
    else
      # 傘なしユーザーが傘もちユーザーをフォローする場合は"リクエスト"になるので
      # その場合にstateカラムをrequestにする
      current_user.update(state: "request")
    end
    
    current_user.follow!(@user)
    
    # 傘持ちユーザーがリクエストを送っている傘なしユーザーをフォロー(承諾)した際に
    # 他に同じ傘持ちユーザーをフォロー(リクエスト)している傘なしユーザーがいた場合にそれらのマッチングを全て解除
    if current_user.have_umbrella == true && Matching.where(followed_id: current_user.id) != nil
      overlap_users = Matching.where(followed_id: current_user.id)
      overlap_users.each do | overlap_user |
        if overlap_user.follower_id != @user.id
          overlap_user.destroy
        end
      end
    end

    if current_user.have_umbrella == true
      message_room = Conversation.find_by(sender_id: current_user.id,recipient_id: @user.id)
      if message_room == nil
        new_message_room = Conversation.create(sender_id: current_user.id,recipient_id: @user.id)
        redirect_to "/conversations/#{new_message_room.id}/messages"
      else
        redirect_to "/conversations/#{message_room.id}/messages"
      end
    else
      # 傘持ちユーザーの時は「承諾」なのでそのままメッセージルームにリダイレクトされるが
      # 傘なしユーザーの時は「リクエスト」なのでユーザー一覧にリダイレクトする
      redirect_to users_path
    end

  end

  def destroy
    @user = Matching.find(params[:id]).followed
    @remove_user = Matching.find(params[:id]).follower

    #removingカラムの値を更新することでActionCableを発火させる
    #さらにremovingカラムをtrue/falseで通知削除の動作分岐をしています(→ channels/remove.coffee)
    @remove_user.update(removing: true)

    current_user.unfollow!(@user)

    # リクエスト承諾後にキャンセルして相互フォロー状態が解除された際に
    # 相手の現在の状態を「メッセージ中」からnilに戻す
    # バグ防止のためにif @user.have_umbrellaで条件分岐したほうがいいかも
    @user.update(state: nil)
    @remove_user.update(state: nil)

    #リクエストキャンセル時に向こう側からのフォローも解除して相互フォロー状態を無効にする
    #キャンセル等の誤操作により自分に対してフォローしている状態が残ると動作バグの原因になるため
    if Matching.find_by(followed_id: current_user.id) && current_user.have_umbrella == false
      @matching_state = Matching.find_by(followed_id: current_user.id)
      @matching_state.destroy
    end

    redirect_to users_path
  end
end
