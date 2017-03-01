require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @textTweet = tweets(:TextTweet1)
    @imageTweet = tweets(:ImageTweet2)
    @tag1 = tags(:Tag1)
    @tag2 = tags(:Tag2)
  end


  # Index

  test "should get index" do
    get tweets_url
    assert_response :success
  end


  # Show

  test "should show tweet" do
    get tweet_url(@textTweet[:id])

    assert_response :success
  end

  test "should not show inexistent tweet" do
    id = 9999999
    get tweet_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"tweet":["The tweet with id=' + id.to_s + ' does not exist."]}}'
  end

  test "should not show tweets with malformed id" do
    id = '99hello99'
    get tweet_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"tweet":["The tweet with id=' + id + ' does not exist."]}}'
  end


  # Create

  test "should create Text Tweet" do
    assert_difference('Tweet.count') do
      post tweets_url, params: { tweet: { text:'Tweet text', type:'text', user_id:1 } }
    end

    assert_response :created
  end

  test "should create Image Tweet" do
    assert_difference('Tweet.count') do
      post tweets_url, params: { tweet: { url:'http://www.image.com/image.jpg', type:'image', user_id:1 } }
    end

    assert_response :created
  end

  test "should not create a non-typed tweet" do
    post tweets_url, params: { tweet: { url:'http://www.image.com/image.jpg', user_id:1 } }

    assert_response :unprocessable_entity
  end

  test "should not create a undefined type of tweet" do
    post tweets_url, params: { tweet: { text:'Tweet text', type:'something_undefined', user_id:1 } }

    assert_response :unprocessable_entity
  end

  test "should not create a Image Tweet without url" do
    post tweets_url, params: { tweet: { text:'Tweet text', type:'image', user_id:1 } }

    assert_response :unprocessable_entity
  end

  test "should not create a Text Tweet without text" do
    post tweets_url, params: { tweet: { url:'http://www.image.com/image.jpg', type:'text', user_id:1 } }

    assert_response :unprocessable_entity
  end

  test "should not create a tweet without user_id" do
    post tweets_url, params: { tweet: { text:'Tweet text', type:'text'} }

    assert_response :unprocessable_entity
  end

  test "should not create a tweet with invalid user_id" do
    post tweets_url, params: { tweet: { text:'Tweet text', type:'text', user_id:9999999} }

    assert_response :unprocessable_entity
  end

  test "should not create a malformed tweet" do
    post tweets_url, params: { tweet: { text:'000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888999999999900000000001111111111222222222233333333334',
                                        type:'text', user_id:1} }

    assert_response :unprocessable_entity
  end


  # Update

  test "should update a text tweet" do
    patch tweet_url(@textTweet[:id]), params: { tweet: { text: 'New text' } }

    assert_response :success
  end

  test "should update a image tweet" do
    patch tweet_url(@imageTweet[:id]), params: { tweet: { url: 'http://newurl.com/image.jpg' } }

    assert_response :success
  end

  test "should not update the type of a tweet" do
    tweet_type = Tweet.find_by(id: @textTweet[:id])[:type]

    patch tweet_url(@textTweet[:id]), params: { tweet: { type:'ImageTweet' } }
    assert_response :success
    patch tweet_url(@textTweet[:id]), params: { tweet: { type:'image' } }
    assert_response :success

    assert Tweet.find_by(id: @textTweet[:id])[:type] == tweet_type
  end

  test "should not update the user_id of a tweet" do
    user_id = Tweet.find_by(id: @textTweet[:id])[:user_id]

    patch tweet_url(@textTweet[:id]), params: { tweet: { user_id:2 } }
    assert_response :success

    assert Tweet.find_by(id: @textTweet[:id])[:user_id] == user_id
  end

  test "should not update a text tweet without text" do
    patch tweet_url(@textTweet[:id]), params: { tweet: { text: '' } }

    assert_response :unprocessable_entity
  end

  test "should not update a image tweet without url" do
    patch tweet_url(@imageTweet[:id]), params: { tweet: { url: '' } }

    assert_response :unprocessable_entity
  end

  test "should not update an empty tweet" do
    patch tweet_url(@textTweet[:id]), params: { tweet: { text: nil, url: nil } }

    assert_response :unprocessable_entity
  end

  test "should not update an malformed tweet" do
    patch tweet_url(@textTweet[:id]), params: { tweet: { text: '000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888999999999900000000001111111111222222222233333333334' } }

    assert_response :unprocessable_entity
  end


  # Destroy
  test "should destroy the tweet" do
    delete tweet_url(@textTweet[:id])

    assert_response :success
    assert_not Tweet.exists?(id: @textTweet[:id])
  end

  test "should not destroy a non-existent tweet" do
    delete tweet_url(9999999)

    assert_response :not_found
  end

  test "should not destroy a tweet with malformed id" do
    delete tweet_url('999hello9999')

    assert_response :not_found
  end


  # Tags

  test "should index the tweet's tags" do
    get tweet_tags_url(@textTweet[:id])

    assert_response :success
  end

  test "should not index the non-existent tweet's tags" do
    id = 9999999
    get tweet_tags_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"tweet":["The tweet with id=' + id.to_s + ' does not exist."]}}'
  end

  test "should not index the tags of tweets with malformed id" do
    id = '99hello99'
    get tweet_tags_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"tweet":["The tweet with id=' + id + ' does not exist."]}}'
  end


  # Add Tag

  test "should create and add tag into a tweet" do
    assert_difference('Tag.count') do
      post tweet_tags_url(@textTweet.id), params: { tag:'newtag' }
    end

    assert_response :created
  end

  test "should add tag, already created, into a tweet" do
    assert_no_difference('Tag.count') do
      post tweet_tags_url(@textTweet.id), params: { tag:'tag2' }
    end

    assert_response :success
  end

  test "should not create a tag into an no-existent tweet" do
    assert_no_difference('Tag.count') do
      post tweet_tags_url(999999999), params: { tag:'tag&%$1' }
    end

    assert_response :not_found
  end

  test "should not create a tag into tweet with invalid id" do
    assert_no_difference('Tag.count') do
      post tweet_tags_url('99hello999'), params: { tag:'tag&%$1' }
    end

    assert_response :not_found
  end

  test "should do nothing when try to inserte a tag, that is already inserted, in a tweet " do
    assert_no_difference('Tag.count') do
      post tweet_tags_url(@textTweet.id), params: { tag:'tag1' }
    end

    assert_response :success
  end

  test "should not create a invalid tag" do
    assert_no_difference('Tag.count') do
      post tweet_tags_url(@textTweet.id), params: { tag:'tag&%$1' }
    end

    assert_response :unprocessable_entity
  end


  # Delete Tag

  test "should delete the relation between a tag and a tweet, but should no destroy the tag" do
    assert_no_difference('Tag.count') do
      delete tweet_tag_url(@textTweet.id, @tag1.id)
    end

    assert_response :success
  end

  test "should delete the relation between a tag and a tweet, and destroy the tag" do
    num_tags = Tag.all.count
    delete tweet_tag_url(@imageTweet.id, @tag2.id)

    assert_response :success
    assert Tag.all.count num_tags-1
  end

  test "should not do nothing if the tag is not included in the tweet" do
    delete tweet_tag_url(@textTweet.id, @tag2.id)

    assert_response :not_found
    assert @response.body == '{"errors":{"tweet":["The tweet does not contain the tag with id='+@tag2.id.to_s+'."]}}'
  end

  test "should not delete a no-existent tag" do
    delete tweet_tag_url(@textTweet.id, 9999999)

    assert_response :not_found
  end

  test "should not delete a the relation between a tag and a no-existent tweet" do
    delete tweet_tag_url(999999, @tag1.id)

    assert_response :not_found
  end
end
