App.remove = App.cable.subscriptions.create "RemoveChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    ban_id = data['ban_id']
    ban_opposite_id = data['ban_opposite_id']
    remove_div = '#request_id_is_' + ban_id
    notification_div = '#cancel_id_is_' + ban_id + ban_opposite_id
    cancel_notification_div = '#cancel_notification_' + ban_id + ban_opposite_id
    $(cancel_notification_div).remove()
    $(".notificaion_box").remove()
    $(notification_div).append data['ban']
      
    if data['ban_removing'] == true
      $(remove_div).remove()

