class RemoveBroadcastJob < ApplicationJob
  queue_as :default

  def perform(ban)
    if ban.have_umbrella == true
      ActionCable.server.broadcast 'remove_channel', ban: ban, ban_id: ban.id, ban_removing: ban.removing
    elsif ban.following.first.id != nil
      ActionCable.server.broadcast 'remove_channel', ban: render_cancel_notification(ban), ban_id: ban.id, ban_removing: ban.removing, ban_opposite_id: ban.following.first.id
    end
  end

  private
    def render_cancel_notification(ban)
      ApplicationController.renderer.render(partial: 'messages/cancel_notification', locals: { ban: ban, ban_opposite_id: ban.following.first.id })
    end
end
