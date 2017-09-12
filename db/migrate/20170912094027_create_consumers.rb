class CreateConsumers < ActiveRecord::Migration[5.0]
  def change
    create_table :consumers do |t|
      t.string :name
      t.string :city
      t.string :profile_img
      t.string :instagram
      t.integer :phone_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
