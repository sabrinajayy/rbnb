class AddTypeToTimeBlock < ActiveRecord::Migration[5.0]
  def change
    add_column :time_blocks, :type, :string
  end
end
