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

end
