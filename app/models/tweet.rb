class Tweet < ApplicationRecord

  validates :url, length: { maximum: 200, message: "the maximum length is 200." }
  validates :text, length: { maximum: 140, message: "the maximum length is 140." }

  belongs_to :user
  has_and_belongs_to_many :tags

  def delete_tag(id_tag)
    tag = Tag.find_by(id: id_tag)
    if tag.tweets.count > 1 # If the tag has more than 1 tweet, only delete the relation
      self.tags.delete(id_tag)
    else # If it has only 1 tweet, destroy the tag
      tag.destroy
    end
  end
end

# Example of adding a audio tweet type: (You must add some code lines in 'tweets_controller.rb' too)
# Create a new class called 'audio_tweet.rb' en 'models' with this content:
#
# class AudioTweet < Tweet
#   validates :url, presence: true
# end
