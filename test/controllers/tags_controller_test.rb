require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag = tags(:Tag1)
  end

  # Index

  test "should get index" do
    get tags_url
    assert_response :success
  end


  #Tweets

  test "should index the tag's tweets" do
    get tag_tweets_url(@tag[:id])

    assert_response :success
  end

  test "should not index the non-existent tag's tweets" do
    id = 9999999
    get tag_tweets_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"tag":["The tag with id=' + id.to_s + ' does not exist."]}}'
  end

  test "should not index the tweets of tags with malformed id" do
    id = '99hello99'
    get tag_tweets_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"tag":["The tag with id=' + id + ' does not exist."]}}'
  end
end
