App.remove = App.cable.subscriptions.create "RemoveChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    ban_id = data['ban_id']
    remove_div = '#request_id_is_' + ban_id
    notification_div = '#cancel_id_is_' + ban_id
    
    $(notification_div).append data['ban']
    if data['ban_removing'] == true
      $(remove_div).remove()

