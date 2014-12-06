
if Meteor.isClient
  Template.main.helpers
    strData: "String Data"
    numData: 123.4321
    dateData: new Date
    arrData: [1..10].map String
    objData: 
      abc: "1234"
      def: new Date

