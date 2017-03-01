# README
## Application requeriments
Very simple version of a twitter-type of application with the following requirements:

1. It is possible to create/edit a user with basic fields like user_name and e-mail
2. It is possible for a user to create/edit/remove a message/tweet
3. It is possible to add are two types of messages/tweets: text and image
4. It most be easy to add more types of messages/tweets like audio or video.
5. It is possible to add/remove tags
6. It is possible to click on a tag to get an overview of other messages/tweets with the same tag
7. It is possible to get an overview of all the different tags and how often they are used
8. Every third message on the screen will be marked with the text "third message" (in de title or next to the message)
9. Every fifth message on the screen will be marked with the text "fifth message" (in de title or next to the message)
10. If a message is both third and fifth message (like the 15th message) it will be marked with the text "third message and fifth message"

## Deployment instructions
Instructions to deploying the application in development evironment

### Install dependecies
Backend dependecies:
```
bundle install
```

Frontend dependecies: 
```
bower install
```
(This wouldn't be necesary, the bower dependecies are pushed to github)


### Build and populate the database 
```
rake db:reset
```

### Run test suits
```
rake test
```

### Deploy the rails server
```
rails server
```

### Access the application
Access with a web browser in:
```
http://localhost:3000
```

## The application has been tested with the next software versions:
```
Rails 5.0.1
ruby 2.2.6p396 (2016-11-15 revision 56800) [x86_64-linux-gnu]
Mozilla Firefox 46.0 for Ubuntu
```


## Author
```
Joan Fernández Bornay <joanf81@gmail.com>
```
