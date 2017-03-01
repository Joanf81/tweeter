require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should create a new user and associate a new tweet with it" do
    user = User.new({email: "testuser3@test.com", username: "testuser3"})
    user.save
    user.tweets.create({text:"tweet text", type:"TextTweet"})

    assert User.exists?(user.id)
    assert user.tweets.count == 1
  end
end
