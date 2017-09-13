class AddDateToConsumerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :consumer_requests, :date, :datetime
  end
end
