App.matching = App.cable.subscriptions.create "MatchingChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    ping = data['ping']
    followed_id = data['followed_id']
    target_div = '#notification_id_is_' + followed_id
    $(".notificaion_box").remove()
    $(target_div).append data['ping']