# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User names:
user1 = 'user1'
user2 = 'user2'


User.create({email: user1 + '@test.com', username: user1})

tweet = TextTweet.new({text: 'Hi world, Im ' + user1 + ' and this is a text tweet.'})
tweet.user = User.find_by({username: user1});
tweet.save

tweet = TextTweet.new({text: 'Hi world, Im ' + user1 + ' and this is another text tweet.'})
tweet.user = User.find_by({username: user1});
tweet.save

tweet = TextTweet.new({text: 'Hi world, Im ' + user1 + ' and this is my 3rd text tweet.'})
tweet.user = User.find_by({username: user1});
tweet.save

tweet = ImageTweet.new({text: 'Hi world, Im ' + user1 + ' and its an image.', url:'https://devbattles.r.worldssl.net/images/upload/hello_world.gif'})
tweet.user = User.find_by({username: user1});
tweet.save

tweet = ImageTweet.new({url:'http://eomp.org/wordpress/wp-content/uploads/2012/04/hello-world.jpg'})
tweet.user = User.find_by({username: user1});
tweet.save


User.create({email: user2 + '@test.com', username: user2})

tweet = TextTweet.new({text: 'Heeeyy, Im ' + user2 + ' and this my text tweet.'})
tweet.user = User.find_by({username: user2});
tweet.save

tweet = ImageTweet.new({text: 'Heeey, Im ' + user2 + ', this is an image tweet, but it has also text.', url:'https://cdn-images-1.medium.com/max/2000/1*Lcgi32fp88wbUUeIV9NVOg.png'})
tweet.user = User.find_by({username: user2});
tweet.save

tweet = ImageTweet.new({url:'https://lonelyplanetwp.imgix.net/2013/10/GettyImages-547085687_medium.jpg?fit=min&q=40&sharp=10&vib=20&w=1470'})
tweet.user = User.find_by({username: user2});
tweet.save
