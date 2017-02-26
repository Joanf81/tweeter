class ImageTweet < Tweet
  validates :url, presence: true
end