class AddBookingReferenceToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :artist_id, :integer, index: true
    add_reference :messages, :consumer_request, foreign_key: true
  end
end
