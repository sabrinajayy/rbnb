class AddMessageRefToConsumerRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :consumer_requests, :messages, foreign_key: true
  end
end
