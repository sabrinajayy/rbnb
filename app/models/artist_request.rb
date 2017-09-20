class ArtistRequest < ApplicationRecord
  belongs_to :consumer_event
  belongs_to :artist
  validates :message, length: { minimum: 10 }
end
