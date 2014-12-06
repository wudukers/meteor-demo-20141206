@Chats = new Meteor.Collection "chats"
@Chatrooms = new Meteor.Collection "chatrooms"

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