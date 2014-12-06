
@chats = [
  {text:"hello1", author:"c3h3"},
  {text:"hello2", author:"c3h3"},
  {text:"hello3", author:"c3h3"},
]

if Meteor.isClient
  Template.main.helpers
    chats: chats
    