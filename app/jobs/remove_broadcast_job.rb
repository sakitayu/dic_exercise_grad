class RemoveBroadcastJob < ApplicationJob
  queue_as :default

  def perform(ban)
    if ban.have_umbrella == true
      ActionCable.server.broadcast 'remove_channel', ban: ban, ban_id: ban.id
    else
      ActionCable.server.broadcast 'remove_channel', ban: render_cancel_notification(ban), ban_id: ban.id
    end
  end

  private
    def render_cancel_notification(ban)
      ApplicationController.renderer.render(partial: 'messages/cancel_notification', locals: { ban: ban })
    end
end
