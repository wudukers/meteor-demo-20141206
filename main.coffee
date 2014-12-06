@Chats = new Meteor.Collection "chats"
@Chatrooms = new Meteor.Collection "chatrooms"

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


    @route "chatroom",
      path: "/chat/:chatroomId"
      template: "chatroom"
      data:
        meta: ->
          chatroomId = Session.get "chatroomId"
          Chatrooms.findOne _id:chatroomId
        chats: ->
          chatroomId = Session.get "chatroomId"      
          Chats.find({chatroomId:chatroomId}, {sort:{postAt:-1}})

      
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


  "createPost": (chatroomId, text)->
    user = Meteor.user()
    
    # FIXME: if chatroomId=undefined

    if not user
      throw new Meteor.Error(401, "You need to login to insert post")

    postAt = new Date
    postData = 
      chatroomId: chatroomId
      text: text
      author: user.profile.name
      userId: user._id
      postAt: postAt

    Chats.insert postData

if Meteor.isClient
  # Template.index.helpers
  #   chatrooms: ->
  #     Chatrooms.find({}, {sort:{createAt:-1}})

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


  # Template.chatArea.helpers
  #   chats: ->
  #     chatroomId = Session.get "chatroomId"      
  #     Chats.find({chatroomId:chatroomId}, {sort:{postAt:-1}})

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


