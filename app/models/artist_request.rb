class ArtistRequest < ApplicationRecord
  belongs_to :consumerevent
  belongs_to :artist
end
