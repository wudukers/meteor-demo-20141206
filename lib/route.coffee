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


