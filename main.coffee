

if Meteor.isClient
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
  