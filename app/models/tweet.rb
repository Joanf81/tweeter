class Tweet < ApplicationRecord

  validates :url, length: { maximum: 200, message: "the maximum length is 200." }
  validates :text, length: { maximum: 140, message: "the maximum length is 140." }

  belongs_to :user

end

# Example of adding a audio tweet type: (You must add some code lines in 'tweets_controller.rb' too)
# Create a new class called 'audio_tweet.rb' en 'models' with this content:
#
# class AudioTweet < Tweet
#   validates :url, presence: true
# end
