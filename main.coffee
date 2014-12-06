
@chats = [
  {text:"hello1", author:"c3h3"},
  {text:"hello2", author:"c3h3"},
  {text:"hello3", author:"c3h3"},
]

@Chats = new Meteor.Collection "chats"

if Meteor.isClient
  Template.main.helpers
    chats: ->
      Chats.find({}, {sort:{postAt:-1}})

  Template.main.events
    "change .text": (e, t)->
      e.stopPropagation()
      username = $("input.username").val()
      text = $("input.text").val()
      postAt = new Date

      postData = 
        text: text
        author: username
        postAt: postAt

      $("input.text").val ""

      Chats.insert postData


if Meteor.isServer
  if Chats.find().count() is 0
    Chats.insert chat for chat in chats