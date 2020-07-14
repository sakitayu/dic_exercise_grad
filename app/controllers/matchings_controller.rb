class MatchingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:matching][:followed_id])
    
    #キャンセル等の誤操作により自分に対してフォローしている状態だった場合Matching状態を無効に戻す
    if Matching.find_by(follower_id: current_user.id)
      @matching_state = Matching.find_by(follower_id: current_user.id)
      @matching_state.destroy
    end
    current_user.follow!(@user)
    if current_user.have_umbrella == true
      message_room = Conversation.find_by(sender_id: current_user.id,recipient_id: @user.id)
      if message_room == nil
        new_message_room = Conversation.create(sender_id: current_user.id,recipient_id: @user.id)
        redirect_to "/conversations/#{new_message_room.id}/messages"
      else
        redirect_to "/conversations/#{message_room.id}/messages"
      end
    end
  end

  def destroy
    @user = Matching.find(params[:id]).followed
    @remove_user = Matching.find(params[:id]).follower
    current_user.unfollow!(@user)

    #removingカラムの値を更新することでActionCableを発火させる
    #さらにremovingカラムをtrue/falseで通知削除の動作分岐をしています(→ channels/remove.coffee)
    @remove_user.update(removing: true)
  end
end
