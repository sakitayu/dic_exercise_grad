App.remove = App.cable.subscriptions.create "RemoveChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    ban_id = data['ban_id']
    #ping_id = data['ping_id']
    ban_opposite_id = data['ban_opposite_id']
    remove_request_div = '#request_id_is_' + ban_id
    notification_message = '#cancel_id_is_' + ban_id + ban_opposite_id
    remove_cancel_notification = '#cancel_notification_' + ban_id + ban_opposite_id
    #remove_notification_div = '#notification_' + ping_id

    #メッセージ画面のパーシャル_cansel_notification.html.erbにリクエストキャンセルを通知
    #その際に傘なしユーザーがリクエストとキャンセルを短時間に何回繰り返しても表示か増えないように削除してから表示するように動作
    $(remove_cancel_notification).remove()
    #$(remove_notification_div).remove()
    $(notification_message).append data['ban']

    #傘なしユーザーが傘持ちユーザーにリクエストキャンセルを行なった場合に傘なしユーザー一覧の承諾通知が消えるように設定
    #$(".notificaion_box").remove()
      
    #傘なしユーザーがフォロー解除した場合にdestroyと同時にユーザーテーブルのremovingカラムがtrueに更新されて
    #userモデルでafter_update_commitで発火したのち傘持ちユーザーのリクエスト一覧に表示された傘なしユーザーが一覧から消える
    if data['ban_removing'] == true
      $(remove_request_div).remove()
      

