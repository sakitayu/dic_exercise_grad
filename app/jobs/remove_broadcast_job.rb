class RemoveBroadcastJob < ApplicationJob
  queue_as :default

  def perform(ban)
    ActionCable.server.broadcast 'remove_channel', ban: ban, ban_id: ban.id#, follower_id: ban.followers.user.id
  end
  
end
