class AddArtistToConsumerRequest < ActiveRecord::Migration[5.0]
  def change
    add_reference :consumer_requests, :artist, foreign_key: true
  end
end
