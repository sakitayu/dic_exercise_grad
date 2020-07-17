App.matching = App.cable.subscriptions.create "MatchingChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    ping = data['ping']
    followed_id = data['followed_id']

    # 傘なしユーザーのユーザー一覧にリクエスト承諾通知をユーザー一覧に表示
    # 動作機序としてはフォローしたときにmatchingモデルのafter_create_commitが発火
    notification_approval_div = '#notification_id_is_' + followed_id
    $(notification_approval_div).append data['ping']

    # 傘持ちユーザーから見たリクエストを自分に送っているユーザー一覧に表示される
    request_user_div = '#request_user_id_is_' + followed_id
    $(request_user_div).append data['ping']