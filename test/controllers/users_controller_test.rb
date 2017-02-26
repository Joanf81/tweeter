require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:TestUser1)
  end

  # Index

  test "should get index" do
    get users_url
    assert_response :success
  end


  # Show

  test "should show user" do
    get user_url(@user[:id])
    assert_response :success
  end

  test "should not show inexistent user" do
    id = 9999999
    get user_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"user":["The user with id=' + id.to_s + ' does not exist."]}}'
  end

  test "should not show users with malformed id" do
    id = '99hello99'
    get user_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"user":["The user with id=' + id + ' does not exist."]}}'
  end


  # Create

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'testuser3@test.com', username: 'testuser3' } }
    end

    assert_response :created
  end

  test "should not create a empty user" do
    post users_url, params: { user: { email: nil, username: nil } }

    assert_response :unprocessable_entity
  end

  test "should not create a repeated user" do
    post users_url, params: { user: { email: 'testuser1@test.com', username: 'testuser1' } }

    assert_response :unprocessable_entity
  end

  test "should not create a invalid user" do
    post users_url, params: { user: { email: 'testu@s.er3@test.com', username: 'testuser3' } }

    assert_response :unprocessable_entity
  end


  # Update

  test "should update user" do
    patch user_url(@user[:id]), params: { user: { email: 'testuser3@test.com', username: 'testuser3' } }

    assert_response :success
  end

  test "should not update a empty user" do
    patch user_url(@user[:id]), params: { user: { email: nil, username: nil } }

    assert_response :unprocessable_entity
  end

  test "should not update a repeated user" do
    patch user_url(@user[:id]), params: { user: { email: 'testuser2@test.com', username: 'testuser2' } }

    assert_response :unprocessable_entity
  end

  test "should not update a invalid user" do
    patch user_url(@user[:id]), params: { user: { email: 'testu@s.er3@test.com', username: 'testuser3' } }

    assert_response :unprocessable_entity
  end


  #Tweets

  test "should index the user's tweets" do
    get user_tweets_url(@user[:id])

    assert_response :success
  end

  test "should not index the non-existent user's tweets" do
    id = 9999999
    get user_tweets_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"user":["The user with id=' + id.to_s + ' does not exist."]}}'
  end

  test "should not index the tweets of users with malformed id" do
    id = '99hello99'
    get user_tweets_url(id)

    assert_response :not_found
    assert @response.body == '{"errors":{"user":["The user with id=' + id + ' does not exist."]}}'
  end
end
