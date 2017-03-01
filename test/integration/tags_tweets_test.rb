require 'test_helper'

class TagsTweetsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @tag = tags(:Tag1)
    @tweet = tweets(:TextTweet1)
  end

  test "should create a new tag and associate it with a tweet" do
    num_tags = @tweet.tags.count
    tag = Tag.create({tag:"tag4"})

    assert @tweet.tags << tag
    assert @tweet.tags.count == num_tags+1
  end

  test "should create a new tweet and associate it with a tag" do
    num_tweets = @tag.tweets.count
    tweet = TextTweet.create({'text':'text', 'user_id':'1'})

    assert @tag.tweets << tweet
    assert @tag.tweets.count == num_tweets+1
  end

  test "should remove the association between a tweet and a tag (without removing the tag)" do
    num_tags = @tweet.tags.count

    assert @tweet.tags.delete(@tag.id)
    assert Tag.exists?(@tag.id)
    assert @tweet.tags.count == num_tags-1
  end

  test "should not remove the associated tweets if you remove a tag" do
    id = @tag.id
    Tag.delete(@tag)

    assert_not Tag.exists?(id)
    assert Tweet.exists?(@tweet.id)
  end

  test "should not remove the associated tags if you remove a tweet" do
    id = @tweet.id
    Tweet.delete(@tweet)

    assert_not Tweet.exists?(id)
    assert Tag.exists?(@tag.id)
  end
end
