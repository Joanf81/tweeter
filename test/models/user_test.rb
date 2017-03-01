require 'test_helper'

class UserTest < ActiveSupport::TestCase

  ## Valid attributes

  test "should save valid user" do
    user = User.new
    user.email = "testuser3@test.com"
    user.username = "testuser3"

    assert user.save
    assert User.exists?(user.id)
  end


  # Invalid attribute email

  test "should not save user without email" do
    user = User.new
    user.username = "testuser3"

    assert_not user.save
    assert_not User.exists?(user.id)
  end

  test "should not save user with empty email" do
    user = User.new
    user.username = "testuser3"
    user.email = ""

    assert_not user.save
    assert_not User.exists?(user.id)
  end

  test "should not save user with duplicate email" do
    user = User.new
    user.username = "testuser1"
    user.email = "testuser1@test.com"

    assert_not user.save
    assert_not User.exists?(user.id)
  end

  test "should not save user with email.length > 50" do
    user = User.new
    user.username = "testuser3"
    user.email = "11111111112222222222333333333344444444445555555555@test.com"

    assert_not user.save
    assert_not User.exists?(user.id)
  end

  test "should not save user with bad format email" do
    user = User.new
    user.username = "testuser3"
    user.email = "user3@test@test.com"

    assert_not user.save
    assert_not User.exists?(user.id)
  end


  # Invalid attribute username

  test "should not save user without username" do
    user = User.new
    user.email = "testuser3@test.com"

    assert_not user.save
    assert_not User.exists?(user.id)
  end

  test "should not save user with empty username" do
    user = User.new
    user.email = "testuser3@test.com"
    user.username = ""

    assert_not user.save
    assert_not User.exists?(user.id)
  end

  test "should not save user with username.length > 30" do
    user = User.new
    user.email = "testuser3@test.com"
    user.username = "1111111111222222222233333333334"

    assert_not user.save
    assert_not User.exists?(user.id)
  end

  test "should not save user with username formed by characters differents than letters or numbers" do
    user = User.new
    user.email = "testuser3@test.com"
    user.username = "test'user"

    assert_not user.save
    assert_not User.exists?(user.id)
  end
end
