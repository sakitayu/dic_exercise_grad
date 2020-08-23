App.matching = App.cable.subscriptions.create "MatchingChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    ping = data['ping']
    followed_id = data['followed_id']
    follower_id = data['follower_id']

    # 傘なしユーザーのユーザー一覧にリクエスト承諾通知を表示する前に
    # リクエストしてるユーザーが他のユーザーとマッチングした場合にその旨を通知する文(厳密にはdivブロック)を削除
    # 自分に対してフォローされない場合は動作せずスルーされるため上記の通知が表示される仕様になっています
    remove_overlap_notification_div = '#remove_overlap_notification_id_is_' + followed_id
    $(remove_overlap_notification_div).remove()
    
    # リクエストしてるユーザーが他のユーザーとマッチングした場合に
    # 詳細ページのリクエストボタンを非表示にする
    remove_request_form__div = '#request_form_id_is_' + follower_id
    $(remove_request_form__div).remove()

    # 傘なしユーザーのユーザー一覧にリクエスト承諾通知を表示
    # 動作機序としてはフォローしたときにmatchingモデルのafter_create_commitが発火
    notification_approval_div = '#notification_id_is_' + followed_id
    $(notification_approval_div).append data['ping']

    # リクエスト中のユーザーが他のユーザーとマッチングした場合(フォローした場合)に通知
    notification_overlap_div = '#overlap_notification_id_is_' + follower_id
    $(notification_overlap_div).append data['overlap']

    # 傘持ちユーザーからみて、リクエストを自分に送っているユーザー一覧に表示
    # 同時にdefault_table_borderの中身を非表示
    request_user_div = '#request_user_id_is_' + followed_id
    default_tr = '#default_tr_id_is_' + followed_id
    $(default_tr).remove()
    $(request_user_div).append data['ping']

    # 他のユーザーーとマッチングした傘持ちユーザーを一覧から削除
    having_user_div = '#having_user_list_id_is_' + follower_id
    $(having_user_div).remove()