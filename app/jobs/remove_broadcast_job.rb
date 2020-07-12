class RemoveBroadcastJob < ApplicationJob
  queue_as :default

  def perform(ban)
    ActionCable.server.broadcast 'remove_channel', ban: ban, ban_id: ban.id
  end
  
end
