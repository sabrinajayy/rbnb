class ArtistRequest < ApplicationRecord
  belongs_to :consumer_event
  belongs_to :artist
end
