
Router.configure
  layoutTemplate: 'layout'

Meteor.startup ->
  Router.map -> 

    @route "index",
      path: "/"
      template: "index"
      data:
        chatrooms: ->
          Chatrooms.find({}, {sort:{createAt:-1}})

      waitOn: ->
        Meteor.subscribe "chatrooms"

    @route "chatroom",
      path: "/chat/:chatroomId"
      template: "chatroom"
      data:
        meta: ->
          chatroomId = Session.get "chatroomId"
          Chatrooms.findOne _id:chatroomId
        chats: ->
          chatroomId = Session.get "chatroomId"      
          Chats.find({}, {sort:{postAt:-1}})
      
      waitOn:->
        Session.set "chatroomId", @params.chatroomId
        Meteor.subscribe "partialChats", @params.chatroomId
        Meteor.subscribe "chatrooms"



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

if Meteor.isServer
  Meteor.publish "partialChats", (chatroomId)->
    Chats.find({chatroomId:chatroomId})    

  Meteor.publish "chatrooms", ->
    Chatrooms.find()    
