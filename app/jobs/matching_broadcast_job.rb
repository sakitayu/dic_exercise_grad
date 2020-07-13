class MatchingBroadcastJob < ApplicationJob
  queue_as :default

  def perform(ping)
    if ping.follower.have_umbrella == false
      ActionCable.server.broadcast 'matching_channel', ping: render_have_umbrella(ping), followed_id: ping.followed_id, follower_id: ping.follower_id
    else
      ActionCable.server.broadcast 'matching_channel', ping: render_have_not_umbrella(ping), followed_id: ping.followed_id, follower_id: ping.follower_id
    end
  end

  private
    def render_have_umbrella(ping)
      ApplicationController.renderer.render(partial: 'users/user', locals: { ping: ping })
    end

    def render_have_not_umbrella(ping)
      ApplicationController.renderer.render(partial: 'users/notification', locals: { ping: ping })
    end
end
