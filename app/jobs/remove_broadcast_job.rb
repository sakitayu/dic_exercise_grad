class RemoveBroadcastJob < ApplicationJob
  queue_as :default

  def perform(ban)
    # メッセージ中にスタート画面に移動した場合、stateがmessageからbrokenに変わるので以下の条件分岐が通る
    if ban.have_umbrella == true && ban.following.first.id != nil && ban.state != "message"
      ActionCable.server.broadcast 'remove_channel', ban: render_cancel_notification(ban), ban_id: ban.id, ban_removing: ban.removing, ban_state: ban.state, ban_opposite_id: ban.following.first.id
    # 以下は傘持ちユーザーが通常の動作を行った場合
    elsif ban.have_umbrella == true
      ActionCable.server.broadcast 'remove_channel', ban: ban, ban_id: ban.id, ban_removing: ban.removing
    # 以下の条件分岐でメッセージ中はuserテーブルが更新されてもキャンセル通知が表示されないようしてます
    # 例えばメッセージ中にプロフィールを編集した時や
    # 傘なしユーザーが「お願いする」を選択後にuserテーブルのstateカラムが"message"になった時
    # ちなみにスタート画面に移動後はstateがmessageからbrokenに変わるので以下の条件分岐が通る
    elsif ban.following.first.id != nil && ban.state != "message"
      ActionCable.server.broadcast 'remove_channel', ban: render_cancel_notification(ban), ban_id: ban.id, ban_removing: ban.removing, ban_state: ban.state, ban_opposite_id: ban.following.first.id
    end
  end

  private
    def render_cancel_notification(ban)
      ApplicationController.renderer.render(partial: 'users/cancel_notification', locals: { ban: ban, ban_opposite_id: ban.following.first.id })
    end
end
