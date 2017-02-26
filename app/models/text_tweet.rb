class TextTweet < Tweet
  validates :text, presence: true
end