class Review < ApplicationRecord
  belongs_to :artist
  belongs_to :user
  belongs_to :consumer_request
  validates :content, length: { minimum: 10 }
  after_save :auto_update_artist_rating

  private
  def auto_update_artist_rating
    artist_reviews = Review.where(artist_id: self.artist.id).map {|review| review.rating.to_f}
    rating = (self.rating + artist_reviews.reduce(0, :+) )/(artist_reviews.count).to_f
    self.artist.update(rating: rating)
  end
end
