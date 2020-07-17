class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index

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
  
    if @messages.length > 10
      @over_ten = true
      @messages = Message.where(id: @messages[-10..-1].pluck(:id))
    end
  
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
  
    if @messages.last
      @messages.where.not(user_id: current_user.id).update_all(read: true)
    end
  
    @messages = @messages.order(:created_at)
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
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
