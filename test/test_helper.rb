ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  ######################### API TOUTE ###########################

  def api_url
    "/api/v1"
  end


  ######################### USERS ROUTES ########################

  def users_url
    api_url + "/users"
  end

  def user_url(user_id)
    users_url + "/" + user_id.to_s
  end

  def user_tweets_url(user_id)
    user_url(user_id) + "/tweets"
  end


  ######################### TWEETS ROUTES ########################

  def tweets_url
    api_url + "/tweets"
  end

  def tweet_url(tweet_id)
    tweets_url + "/" + tweet_id.to_s
  end

  def tweet_tags_url(tweet_id)
   tweet_url(tweet_id) + "/tags"
  end

  def tweet_tag_url(tweet_id, tag_id)
    tweet_tags_url(tweet_id) + "/" + tag_id.to_s
  end


  ######################### TAGS ROUTES ########################

  def tags_url
    api_url + "/tags"
  end

  def tag_tweets_url(tag_id)
    tags_url + "/" + tag_id.to_s + "/tweets"
  end
end
