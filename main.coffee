@Chats = new Meteor.Collection "chats"

if Meteor.isClient
  Template.main.helpers
    chats: ->
      Chats.find({}, {sort:{postAt:-1}})
      
  Template.main.events
    "change .text": (e, t)->
      user = Meteor.user()

      e.stopPropagation()
      username = $("input.username").val()
      text = $("input.text").val()
      postAt = new Date

      postData = 
        text: text
        author: user.profile.name
        postAt: postAt

      $("input.text").val ""

      Chats.insert postData


