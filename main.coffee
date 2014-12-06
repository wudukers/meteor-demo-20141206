
@arrData = [10..8].map String
@reactiveArrData = new ReactiveDict
@reactiveArrData.set("array", arrData);

if Meteor.isClient
  Template.main.helpers
    strData: "String Data"
    numData: 123.4321
    dateData: new Date
    arrData: arrData
    objData: 
      abc: "1234"
      def: new Date

    funData: (x,y)->
      x+y

    reactiveArrData: ->
      reactiveArrData.get "array"