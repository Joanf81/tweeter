require 'test_helper'

class TweetTest < ActiveSupport::TestCase

  # Valid attributes

  test "should save valid text tweet" do
    text_tweet = TextTweet.new
    text_tweet.text = "Test text."
    text_tweet.user_id = 1

    assert text_tweet.save
    assert TextTweet.exists?(text_tweet.id)
  end

  test "should save valid image tweet without text" do
    image_tweet = ImageTweet.new
    image_tweet.url = "http://urlimage.com/image.jpg"
    image_tweet.user_id = 1

    assert image_tweet.save
    assert ImageTweet.exists?(image_tweet.id)
  end

  test "should save valid image tweet with text" do
    image_tweet = ImageTweet.new
    image_tweet.url = "http://urlimage.com/image.jpg"
    image_tweet.text = "Text for the image."
    image_tweet.user_id = 1

    assert image_tweet.save
    assert ImageTweet.exists?(image_tweet.id)
  end


  # Invalid params common in the two types of tweets

  test "should not save tweet with bad type param" do
    assert_raises(Exception) { Tweet.new({'text':'text  test 12345678', 'user_id': 1, 'type':'undefined_tweet_type'}) }
    assert_not TextTweet.exists?({'text':'text  test 12345678'})
  end

  test "should not save tweet without user_id" do
    assert_not TextTweet.new({'text':'text  test 12345678'}).save
    assert_not TextTweet.exists?({'text':'text  test 12345678'})
  end

  test "should not save tweet with user_id inexistent in db" do
    assert_not TextTweet.new({'text':'text  test 12345678', 'user_id':'99999'}).save
    assert_not TextTweet.exists?({'text':'text  test 12345678'})
  end

  test "should not save tweet with invalid user_id" do
    assert_not TextTweet.new({'text':'text  test 12345678', 'user_id':'99hello999'}).save
    assert_not TextTweet.exists?({'text':'text  test 12345678'})
  end

  test "should not save tweet with text.lenght > 140" do
    text_tweet = TextTweet.new
    text_tweet.text = "0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999"
    text_tweet.text+= "000000000011111111112222222222333333333344444444445"
    text_tweet.user_id = 1

    assert_not text_tweet.save
    assert_not TextTweet.exists?(text_tweet.id)
  end

  test "should not save tweet with url.lenght > 200" do
    image_tweet = ImageTweet.new
    image_tweet.url = "0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999"
    image_tweet.url+= "00000000001111111111222222222233333333334444444444555555555566666666667777777777888888888899999999991"
    image_tweet.user_id = 1

    assert_not image_tweet.save
    assert_not ImageTweet.exists?(image_tweet.id)
  end


  # Invalid attributes in TextTweets

  test "should not save TextTweet without text" do
    text_tweet = TextTweet.new
    text_tweet.url = "http://url.com"
    text_tweet.user_id = 1

    assert_not text_tweet.save
    assert_not TextTweet.exists?(text_tweet.id)
  end


  # Invalid attributes in ImageTweets

  test "should not save ImageTweet without url" do
    image_tweet = ImageTweet.new
    image_tweet.text = "Text"
    image_tweet.user_id = 1

    assert_not image_tweet.save
    assert_not ImageTweet.exists?(image_tweet.id)
  end

end
