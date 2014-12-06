@Chats = new Meteor.Collection "chats"
@Chatrooms = new Meteor.Collection "chatrooms"

Router.configure
  layoutTemplate: 'layout'

Meteor.startup ->
  Router.map -> 

    @route "index",
      path: "/"
      template: "index"

    @route "chatroom",
      path: "/chatroom/:chatroomId"
      template: "chatroom"
      data:
        meta: ->
          chatroomId = Session.get "chatroomId"
          Chatrooms.findOne _id:chatroomId
      
      waitOn:->
        Session.set "chatroomId", @params.chatroomId





Meteor.methods
  "createChatroom": (name)->
    user = Meteor.user()    
    if not user
      throw new Meteor.Error(401, "You need to login to insert post")

    chatroomData =
      name: name
      creator: user.profile.name
      creatorId: user._id    
      createAt: new Date
    
    Chatrooms.insert chatroomData


  "createPost": (text)->
    user = Meteor.user()
    
    if not user
      throw new Meteor.Error(401, "You need to login to insert post")

    postAt = new Date
    postData = 
      text: text
      author: user.profile.name
      userId: user._id
      postAt: postAt

    Chats.insert postData

if Meteor.isClient
  Template.index.helpers
    chatrooms: ->
      Chatrooms.find({}, {sort:{createAt:-1}})

  Template.index.events
    "change .chatroomName": (e, t)->
      
      e.stopPropagation()
      text = $("input.chatroomName").val()

      Meteor.call "createChatroom", text, (err, res)->
        $("input.chatroomName").val("")
        if not err
          console.log "res = "
          console.log res

        else
          console.log "err = "
          console.log err


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


