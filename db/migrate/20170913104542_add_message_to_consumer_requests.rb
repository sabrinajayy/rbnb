class AddMessageToConsumerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :consumer_requests, :message, :text
  end
end
