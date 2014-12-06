
Template.chatArea.events
  "change .text": (e, t)->
    
    e.stopPropagation()
    text = $("input.text").val()

    chatroomId = Session.get "chatroomId"

    Meteor.call "createPost", chatroomId, text, (err, res)->
      $("input.text").val("")
      if not err
        console.log "res = "
        console.log res

      else
        console.log "err = "
        console.log err
