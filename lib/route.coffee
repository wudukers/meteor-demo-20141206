Router.configure
  layoutTemplate: 'layout'

Router.map -> 
  @route "index",
    path: "/"
    template: "index"
    data: ->
      resData = 
        chatrooms: ->
          Chatrooms.find({}, {sort:{createAt:-1}})
    waitOn: ->
      Meteor.subscribe "chatrooms"

  @route "chatroom",
    path: "/chat/:chatroomId"
    template: "chatroom"
    data: ->
      resData = 
        meta: =>
          Chatrooms.findOne _id:@params.chatroomId
        chats: =>
          Chats.find({}, {sort:{postAt:-1}})    
    waitOn:->
      Session.set "chatroomId", @params.chatroomId
      Meteor.subscribe "partialChats", @params.chatroomId
      Meteor.subscribe "chatrooms"
