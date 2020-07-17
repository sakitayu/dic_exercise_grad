App.matching = App.cable.subscriptions.create "MatchingChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    ping = data['ping']
    followed_id = data['followed_id']
    # 傘持ちユーザーから見たリクエストを自分に送っているユーザー一覧に表示される
    request_user_div = '#request_user_id_is_' + followed_id
    # 傘なしユーザー
    notification_approval_div = '#notification_id_is_' + followed_id

    # リクエスト承諾通知をユーザー一覧に表示 (その際すでに表示されていた場合は消したのちに表示)
    # 動作機序としてはフォローしたときにmatchingモデルのafter_create_commitが発火
    # その後に
    $(".notificaion_box").remove()
    $(request_user_div).append data['ping']
    $(notification_approval_div).append data['ping']