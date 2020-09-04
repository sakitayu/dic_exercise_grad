class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    if user_signed_in? && current_user.area != nil
      @matching = Matching.find_by(follower_id: current_user.id)
      #会話相手ユーザーのIDを@opposite_idに格納
      if @conversation.sender_id == current_user.id
        @opposite_id = @conversation.recipient_id
      else
        @opposite_id = @conversation.sender_id
      end
      #会話相手ユーザーのテーブルを@opposite_userに格納
      @opposite_user = User.find(@opposite_id)

      @messages = @conversation.messages
    
      @messages = @messages.order(:created_at)
      @message = @conversation.messages.build

      # 傘なしユーザーがメッセージルームに移動した場合、stateカラムがmessageになる
      # すでにstateがmessageになっている場合はなにもしない(データベースへの無駄なアクセスを増やさないため)
      if current_user.have_umbrella == false && current_user.state != "message"
        current_user.update(state: "message")
      end
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation, anchor: 'latest_position')
    else
      render 'index'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
