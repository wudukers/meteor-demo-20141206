@Chats = new Meteor.Collection "chats"

Meteor.methods
  "createPost": (text)->
    user = Meteor.user()
    
    if not user
      throw new Meteor.Error(401, "You need to login to insert post")

    postAt = new Date
    postData = 
      text: text
      author: user.profile.name
      postAt: postAt

    Chats.insert postData

if Meteor.isClient
  Template.main.helpers
    chats: ->
      Chats.find({}, {sort:{postAt:-1}})

  Template.main.events
    "change .text": (e, t)->
      
      e.stopPropagation()
      text = $("input.text").val()

      Meteor.call "createPost", text, (err, res)->
        $("input.text").val("")
        if not err
          console.log "res = "
          console.log res

        else
          console.log "err = "
          console.log err


