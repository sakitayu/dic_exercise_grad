App.remove = App.cable.subscriptions.create "RemoveChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    ban_id = data['ban_id']
    #ping_id = data['ping_id']
    ban_opposite_id = data['ban_opposite_id']

    # メッセージ画面のパーシャル_cansel_notification.html.erbにリクエストキャンセルを通知
    # その際に傘なしユーザーがリクエストとキャンセルを短時間に何回繰り返しても表示か増えないように削除してから表示するように動作
    remove_cancel_notification = '#cancel_notification_' + ban_id + ban_opposite_id
    $(remove_cancel_notification).remove()
    #notification_message = '#cancel_id_is_' + ban_id + ban_opposite_id
    notification_message = '#cancel_id_is_' + ban_opposite_id
    $(notification_message).append data['ban']
    # 傘なしユーザーがスタート画面に移動した際に傘もちユーザーのユーザー一覧から削除
    default_tr = '#default_tr_id_is_' + ban_id
    $(default_tr).remove()

    # 傘持ちユーザーがキャンセルをされた場合にユーザー詳細画面の上部説明と承諾フォームを非表示にする
    remove_disc_p = '#remove_disc_id_is_' + ban_id + ban_opposite_id
    remove_form_div = '#remove_form_id_is_' + ban_id + ban_opposite_id
    $(remove_disc_p).remove()
    $(remove_form_div).remove()

    # 傘なしユーザーが傘持ちユーザーにリクエストキャンセルを行なった場合に傘なしユーザー一覧の承諾通知が消えるように設定
    remove_notificaion_box = '#notificaion_box_id_is_' + ban_id
    $(remove_notificaion_box).remove()

    # 傘なしユーザーが傘持ちユーザーにリクエストキャンセルを行なった場合に(データベースのマッチング情報から分岐で)
    # 傘なしユーザー一覧の承諾通知が消えるように設定
    # 他のユーザー操作の時も動作してしまうバグを回避するために現在のユーザーが操作した場合しか動作しないように
    # current_user.idとban_idをdivのid上で照合させています
    remove_confirm_notification = '#confirm_id_is_' + ban_id
    $(remove_confirm_notification).remove()
      
    # 傘なしユーザーがフォロー解除した場合にdestroyと同時にユーザーテーブルのremovingカラムがtrueに更新されて
    # userモデルでafter_update_commitで発火したのち傘持ちユーザーのリクエスト一覧に表示された傘なしユーザーが一覧から消える
    # DOMにレンダーされた場合とDBから表示された場合の両方を消すようになっている
    remove_request_div = '#request_id_is_' + ban_id
    remove_request_on_db_div = '#request_user_list_id_is_' + ban_id
    if data['ban_removing'] == true
      $(remove_request_div).remove()
      $(remove_request_on_db_div).remove()
      

