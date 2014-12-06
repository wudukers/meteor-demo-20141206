Meteor.publish "partialChats", (chatroomId)->
  Chats.find({chatroomId:chatroomId})    

Meteor.publish "chatrooms", ->
  Chatrooms.find()    
