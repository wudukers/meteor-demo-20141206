Template.index.events
  "change .chatroomName": (e, t)->
    
    e.stopPropagation()
    text = $("input.chatroomName").val()
    $("input.chatroomName").val("")

    Meteor.call "createChatroom", text, (err, res)->
      if not err
        console.log "res = "
        console.log res

      else
        console.log "err = "
        console.log err
