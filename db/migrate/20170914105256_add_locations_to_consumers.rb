class AddLocationsToConsumers < ActiveRecord::Migration[5.0]
  def change
    add_column :consumers, :address, :string
    add_column :consumers, :latitude, :float
    add_column :consumers, :longitude, :float
  end
end
