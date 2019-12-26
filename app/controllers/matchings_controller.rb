class MatchingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:matching][:followed_id])
    current_user.follow!(@user)
    if current_user.umbrella.have_umbrella
      message_room = Conversation.find_by(sender_id: current_user.id,recipient_id: @user.id)
      #binding.pry
      redirect_to "/conversations/#{message_room.id}/messages" #conversations_path(sender_id: current_user.id, recipient_id: @user.id)
    end
  end

  def destroy
    @user = Matching.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
