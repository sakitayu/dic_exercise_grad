class MatchingBroadcastJob < ApplicationJob
  queue_as :default

  def perform(ping)
    ActionCable.server.broadcast 'matching_channel', ping: render_ping(ping), followed_id: ping.followed_id, follower_id: ping.follower_id
  end

  private
    def render_ping(ping)
      ApplicationController.renderer.render(partial: 'users/user', locals: { ping: ping })
    end
end
