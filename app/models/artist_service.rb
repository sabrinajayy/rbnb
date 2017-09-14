class ArtistService < ApplicationRecord
  belongs_to :artist
  belongs_to :consumer_request

end
