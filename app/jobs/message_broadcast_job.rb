class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'message_channel', message: render_message(message), user_id: message.user_id, conversation_id: message.conversation_id
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end
end
