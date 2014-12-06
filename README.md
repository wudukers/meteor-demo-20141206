# Meteor Demo 20141206

To get the most from this project, please follow the commit log to learn the meteor project workflow.

## Before getting started

This project use coffeescript and jade. Please enter these command to the terminal.
```
meteor add coffeescript
meteor add mquandalle:jade
```

To serve your project to your team member, please follow the following steps. (Optional)

Download ngrok from https://ngrok.com/

unzip the file and run ngrok.
```
$ unzip /path/to/ngrok.zip
$ ./ngrok 3000
```
you will get a url like this:`http://56aefb0f.ngrok.com/`. Share the url with your team member.

Add the environment vairable and start meteor.
```
ROOT_URL=http://your_ngrok_id.ngrok.com MONGO_URL=mongodb://localhost:27017/meteordemo meteor
```

