class AddLongLatToConsumerEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :consumer_events, :latitude, :float
    add_column :consumer_events, :longitude, :float
  end
end
