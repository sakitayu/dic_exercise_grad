class MatchingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:matching][:followed_id])
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
    #@following_user = Matching.find(params[:id]).follower
    current_user.unfollow!(@user)
    #どちらかがフォローを外したら両方ともフォローが外れるようにする
    #@user.delete_all
    #both_following = Matching.find(params[:id]).followed
    #removingカラムの値を更新することでActionCableを発火させる
    @remove_user.update(removing: true)
  end
end
